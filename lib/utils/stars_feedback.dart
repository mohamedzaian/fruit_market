import 'package:flutter/material.dart';

class Feedback extends StatefulWidget {
  final double? size;
   Feedback({super.key,  this.size});

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  int selectedStars = 0;
  final double size = Feedback().size!;

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedStars = index + 1;
            });
          },
          child: Icon(
            index < selectedStars ? Icons.star : Icons.star_border,
            color: Colors.yellow,
            size: size,
          ),
        ),
      ),
    );
  }
}
