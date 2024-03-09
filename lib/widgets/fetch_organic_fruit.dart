import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/get_favorite_product/get_favorite_product_cubit.dart';
import '../cubit/get_product/get_data_cubit.dart';
import '../models/product_model.dart';
import '../screen/details_screen.dart';
import '../utils/firestore_key.dart';

class FetchOrganicFruit extends StatefulWidget {
  const FetchOrganicFruit({super.key});

  @override
  State<FetchOrganicFruit> createState() => _FetchOrganicFruitState();
}

class _FetchOrganicFruitState extends State<FetchOrganicFruit> {
  void initState() {
    context.read<GetDataCubit>().getOrganicFruits();


    super.initState();
  }
  Widget build(BuildContext context) {
    return BlocBuilder<GetDataCubit, GetDataState>(
      builder: (context, state) {



        if (state is success) {

          final  listOfOrganic = state.product;
          print('the lenght of fruit is ${state.product.length}');
          return Container(
            height: 220,
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final Productmodel organic = listOfOrganic[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return DetailsScreen(
                                name: organic.name,
                                price: organic.price,
                                image: organic.image,
                                details: organic.details
                            );
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
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      image: DecorationImage(
                                          image: NetworkImage(organic.image

                                          ),
                                          fit: BoxFit.fill))),
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
                                          organic.isFavorite =
                                          !organic.isFavorite;
                                        });
                                        if (organic.isFavorite) {
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
                                            organic.name,
                                            'price':
                                            organic.price,
                                            'image':
                                            organic.image,
                                            'id': id,
                                            'userid': FirebaseAuth
                                                .instance
                                                .currentUser
                                                ?.uid
                                          });
                                        } else {
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
                                              .delete();
                                          context
                                              .read<
                                              GetFavoriteProductCubit>()
                                              .getFavoriteProduct();
                                        }
                                      },
                                      icon: Icon(Icons.favorite),
                                      color: organic.isFavorite
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
                            organic.name,
                            style: TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            '${organic.price} EG Per/kilo',
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
        if(state is loading) {

          Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox();
      },
    );
  }
}
