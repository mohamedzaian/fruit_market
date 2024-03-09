import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/get_product/get_data_cubit.dart';
import '../cubit/get_stone_fruit/get_stone_fruit_cubit.dart';
import '../models/product_model.dart';
import '../screen/details_screen.dart';
import '../utils/firestore_key.dart';

class GetStoneFruit extends StatefulWidget {
  const GetStoneFruit({super.key});

  @override
  State<GetStoneFruit> createState() => _GetStoneFruitState();
}

class _GetStoneFruitState extends State<GetStoneFruit> {
  @override
  void initState() {
    context.read<GetStoneFruitCubit>().getStoneFruite();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetStoneFruitCubit, GetStoneFruitState>(
        builder: (context, state)
    {
      if (state is GetStoneLoadin) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is GetStoneSuccess) {
      final listOfStone = state.product;

        return Container(
          height: 220,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final  Productmodel stone = listOfStone[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return DetailsScreen(
                              name:stone.name,
                              price: stone.price,
                              image: stone.image,
                              details: stone.details);
                        }));
                  },
                  child: Container(
                    height: 220,
                    width: 118,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 143,
                              width: 118,
                              child: CachedNetworkImage(imageUrl: stone.image,),
                            ),
                            Positioned(
                              top: 5,
                              right: 9,
                              child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                  Colors.grey.shade300,
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        stone.isFavorite =
                                        !stone.isFavorite;
                                      });
                                      if (stone.isFavorite) {
                                        final id = FirebaseFirestore
                                            .instance
                                            .collection(FireStoreKey()
                                            .favoriteCollection)
                                            .doc()
                                            .id;

                                        FirebaseFirestore.instance
                                            .collection(FireStoreKey()
                                            .favoriteCollection)
                                            .doc(id)
                                            .set({
                                          'name':
                                          stone.name,
                                          'price':
                                          stone.price,
                                          'image':
                                          stone.image,
                                          'id': id,
                                          'userid': FirebaseAuth
                                              .instance
                                              .currentUser
                                              ?.uid
                                        });
                                      } else {
                                        final docId =
                                            FirebaseFirestore
                                                .instance
                                                .collection(
                                                FireStoreKey()
                                                    .favoriteCollection)
                                                .doc()
                                                .id;
                                        FirebaseFirestore.instance
                                            .collection(FireStoreKey()
                                            .favoriteCollection)
                                            .doc(docId)
                                            .delete();
                                      }
                                    },
                                    icon: Icon(Icons.favorite),
                                    color: stone.isFavorite
                                        ? Colors.red
                                        : Colors.white,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          stone.name,
                          style: TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '${stone.price} EG Per/kilo',
                          style: TextStyle(
                              fontSize: 12, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 20,
                );
              },
              itemCount: state.product.length),
        );
      }
      return SizedBox(
        height: 10,
        child: Text('mohamed'),
      );
    },
    );

    }

  }

