import 'package:flutter/material.dart';
import 'package:fruit_market/screen/account_screen.dart';
import 'package:fruit_market/screen/cart_screen.dart';
import 'package:fruit_market/screen/favorite_screen.dart';
import 'package:fruit_market/utils/main_color.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final List<Widget> listOfScreen = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen()

  ];

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
          Icon(
            Icons.notifications,
            color: Colors.white,
          )
        ],
        toolbarHeight: 114,
        backgroundColor: mainColor,
      ),
      body: listOfScreen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: mainColor,
        onTap: (index) {

          setState(() {
            currentIndex = index;
          });
          git stash


        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Shopping Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Account'),
        ],
      ),
    );
  }
}
