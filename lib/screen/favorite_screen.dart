import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/get_favorite_product/get_favorite_product_cubit.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:fruit_market/utils/main_color.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    context.read<GetFavoriteProductCubit>().getFavoriteProduct();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        backgroundColor: mainColor,
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: BlocBuilder<GetFavoriteProductCubit, GetFavoriteProductState>(
        builder: (context, state) {
          if (state is FavoriteIsEmpty)
          return Center(
            child: Text('the list is empty',
            style:TextStyle(
              color: mainColor,
              fontSize: 26
            ),)
          );
          else
          {

            if (state is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetFavoriteSuccess) {

              final listOfFavorite = state.listOfFavotire;
              if (listOfFavorite.isEmpty)
                {
                  return Center(
                    child: Text('The List is empty',
                    style: TextStyle(
                      color: mainColor,
                      fontSize: 26
                    ),),
                  );
                }
              return Padding(
                padding: const EdgeInsets.fromLTRB(19, 19, 19, 0),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Container(
                        height: 120,
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 95,
                              width: 95,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          listOfFavorite[index]['image']))),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listOfFavorite[index]['name'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Pick up from organic farms',
                                  style: TextStyle(
                                    color: Color(0xffB2B2B2),
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${listOfFavorite[index]['price']} Per/kg '),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: mainColor,
                                        fixedSize: Size(80, 20)),
                                    onPressed: () async {

                                      await FirebaseFirestore.instance
                                          .collection(
                                              FireStoreKey().favoriteCollection)
                                          .doc(listOfFavorite[index]['id'])
                                          .delete();
                                      setState(() {
                                        listOfFavorite
                                            .remove(listOfFavorite[index]);
                                      });
                                    },
                                    child: Text(
                                      'Delet',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: listOfFavorite.length),
              );
            }
          }


          return SizedBox();

        },
      ),
    );
  }
}
