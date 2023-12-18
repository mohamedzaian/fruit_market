import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

import 'main_color.dart';

class CustomDotts extends StatelessWidget {
  const CustomDotts({super.key, required this.dotindex});
final double dotindex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(dotsCount: 3,
      position: dotindex ,
      decorator: DotsDecorator(
      color: Colors.grey,
      activeColor: mainColor,


    ),);
  }
}
