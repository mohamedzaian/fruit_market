import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/get_cart/get_cart_cubit.dart';
import 'package:fruit_market/utils/main_color.dart';

import '../utils/firestore_key.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    context.read<GetCartCubit>().getCart();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: mainColor,
          title: Text(
            'Shopping Cart',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        body: BlocBuilder<GetCartCubit, GetCartState>(
          builder: (context, state) {
            if (state is CartEmpty )
              {
                return Center(
                  child: Text('the cart is empty',style: TextStyle(
                    fontSize: 20,
                    color: mainColor
                  ),),
                );
              }
            if (state is GetCartLoading)
              {
                return Center(child:
                  CircularProgressIndicator(),);
              }

            if (state is GetCartSucces) {
              final List cart = state.listOfItems;
              double total = 0;

              for (int i = 0; i < cart.length; i++) {
                total += cart[i]['price'] * cart[i]['count'];
              }
              if (cart.isEmpty)
                {
                  return Center(
                    child: Text('the cart is empty',
                    style: TextStyle(
                      fontSize: 20,
                      color: mainColor
                    ),),
                  );
                }

              return Stack(
                children: [
                  Container(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            height: 130,
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 95,
                                  width: 95,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            cart[index]['image']),
                                      )),
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      cart[index]['name'],
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    Text(
                                      "${cart[index]['price']} per/Kg",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection(FireStoreKey()
                                              .cartCollection)
                                              .doc(cart[index]['id'])
                                              .delete();
                                          setState(() {
                                            cart.remove(cart[index]);
                                          });
                                        },
                                        icon: Icon(Icons.delete)),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (cart[index]['count'] >
                                                      1)
                                                    cart[index]['count']--;
                                                  else
                                                    null;
                                                });
                                              },
                                              icon: Icon(Icons.minimize)),
                                        ),
                                        Text(
                                          '${cart[index]['count']}',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Center(
                                          child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  cart[index]['count']++;
                                                });
                                              },
                                              icon: Icon(Icons.add)),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(
                            height: 2,
                          );
                        },
                        itemCount: cart.length),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'ToTal : ${total.toString()}  ',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                print(total);
                              },
                              child: Text(
                                'Place Order',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColor,
                                  fixedSize: Size(148, 40)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }






            return SizedBox(
              height: 10,
            );
          },
        ));
  }
}
