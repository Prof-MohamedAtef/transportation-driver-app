import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/city_model.dart';

class CityCard extends StatelessWidget {
  final City city;

  const CityCard({required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Set width for each card
      height: 160,
      margin: const EdgeInsets.only(right: 12.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              child: Image.asset(
                city.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${city.price} / trip',
                    style: TextStyle(color: Colors.green[800], fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
