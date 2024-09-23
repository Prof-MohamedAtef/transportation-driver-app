import 'package:flutter/material.dart';

class GreetingsWidget extends StatelessWidget {
  final String? name;

  const GreetingsWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[40],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Hey, $name",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(width: 8,),
              const Icon(
                Icons.waving_hand,
                color: Color(0xffffe600),
                size: 20,
              ),
            ],
          ),
          Text(
            "Where are you going?",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
