import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthCustomRowWidget extends StatelessWidget {
  String? text1, text2;
  final VoidCallback? onPressed;
  AuthCustomRowWidget(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Text(
            text1.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text2.toString(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
