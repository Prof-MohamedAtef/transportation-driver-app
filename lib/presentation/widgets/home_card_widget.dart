import 'package:flutter/material.dart';

class RoundedContainerWithImage extends StatelessWidget {
  final String imageUrl;

  const RoundedContainerWithImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.blue,
        ),
        child: Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity),
      ),
    );
  }
}
