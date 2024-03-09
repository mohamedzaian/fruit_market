import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_market/cubit/get_product/get_data_cubit.dart';
import 'package:fruit_market/cubit/get_stone_fruit/get_stone_fruit_cubit.dart';
import 'package:fruit_market/screen/details_screen.dart';
import 'package:fruit_market/utils/firestore_key.dart';
import 'package:fruit_market/utils/main_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fruit_market/widgets/fetch_organic_fruit.dart';
import 'package:like_button/like_button.dart';
import '../models/product_model.dart';
import '../widgets/fetch_stone_fruit.dart';
// Mohamed Zayan

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final docId = FirebaseFirestore.instance
      .collection(FireStoreKey().productCollection)
      .doc()
      .id;
  @override
  void initState() {

    super.initState();
  }

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fruit Market',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.notifications,
            color: Colors.white,
          )
        ],
        toolbarHeight: 114,
        backgroundColor: mainColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GetDataCubit>().getOrganicFruits();
          context.read<GetStoneFruitCubit>().getStoneFruite();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Organic Fruits',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Pick up from organic farms',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                SizedBox(
                  height: 17,
                ),
                FetchOrganicFruit(),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Stone Fruits',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  'Fresh Stone Fruits',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
                SizedBox(
                  height: 17,
                ),
                GetStoneFruit()





              ],
            ),
          ),
        ),
      ),
    );
  }
}
