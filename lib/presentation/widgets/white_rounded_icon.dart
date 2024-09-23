import 'package:flutter/material.dart';

class IconWithCircle extends StatelessWidget{

  final IconData iconData;
  final double iconSize;
  final VoidCallback onTap;

  const IconWithCircle({super.key,
    required this.iconData,
    required this.iconSize,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: Icon(
            iconData, size: iconSize, color: const Color(0xFF5b5b5b),
          ),
        ),
      ),
    );
  }
}