


import 'package:flutter/material.dart';

class OnboardingItems extends StatelessWidget {
  OnboardingItems({
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image;
  final String title;
  final String subtitle;


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Container(
          height: 210,
            width: 272,
            child: Image.asset(image)),
        SizedBox(height: 50,),
        Text(
          title,
          style: TextStyle(fontSize: 20,
          ),
        ),
        SizedBox(height: 18,),

        Text(
          subtitle,
          style: TextStyle(fontSize: 14,
            fontWeight: FontWeight.w400
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}
