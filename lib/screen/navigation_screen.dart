import 'package:flutter/material.dart';
import 'package:fruit_market/screen/account_screen.dart';
import 'package:fruit_market/screen/add_product.dart';
import 'package:fruit_market/screen/cart_screen.dart';
import 'package:fruit_market/screen/favorite_screen.dart';
import 'package:fruit_market/screen/home_screen.dart';

import '../utils/main_color.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  @override
  int currentIndex = 0;
  final List<Widget> listOfScreen = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
    AddProductScreen()
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: listOfScreen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        selectedItemColor: mainColor,
        onTap: (index) {
          if (index == 1)
            {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)
              {
                return CartScreen();
              }
              )

              );
              return;

            };
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Shopping Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.plus_one), label: 'Add Product'),
        ],
      ),
    );
  }
}
