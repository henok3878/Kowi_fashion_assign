import 'package:flutter/material.dart';

class CircularAvatar extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  const CircularAvatar({required this.height, required this.width, required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width/2),
      ),
      height: height,
      width: width,
      child: Image.network(
        image,
        height: height,
        width: width,
        fit: BoxFit.fill,
      ),
    );
  }
}
