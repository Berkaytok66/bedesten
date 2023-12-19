import 'package:flutter/material.dart';

class SquareTitle extends StatelessWidget {
  final String imagePath;
  const SquareTitle({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(20),),
      //color: Colors.white,
      child: Image.asset(imagePath,
      height: 60,),
    );
  }
}
