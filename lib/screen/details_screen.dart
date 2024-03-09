import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/add_to_cart/add_to_cart_cubit.dart';
import 'package:fruit_market/utils/main_color.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.details});

  final String name;
  final double price;
  final String image;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 176,
                width: MediaQuery
                    .sizeOf(context)
                    .width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                details,
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              SizedBox(
                height: 310,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'EG ${price.toString()} Per/Kg',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  BlocListener<AddToCartCubit, AddToCartState>(
                    listener: (context, state) {
                      if (state is AddToCartSucces) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message,
                            ),
                                duration: Duration(milliseconds: 500)
                                ,
                                backgroundColor: Colors.green)
                        );
                      }
                    },
                    child: BlocBuilder<AddToCartCubit, AddToCartState>(
                      builder: (context, state) {
                        if (state is AddToCartLoading)

                          {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        return ElevatedButton(
                            onPressed: () {

                              context
                                  .read<AddToCartCubit>()
                                  .addToCart(name, price, image);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: mainColor,
                                fixedSize: Size(148, 40)),
                            child: Text(
                              'Buy It',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.white),
                            ));
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
