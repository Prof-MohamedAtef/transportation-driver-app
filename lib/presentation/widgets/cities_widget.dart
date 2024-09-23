import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/city_model.dart';
import 'city_card_widget.dart';

final List<City> cities = [
  City(
    name: 'Alexandria',
    imageUrl:
    'assets/governorates/alex.jpg',
    price: 120,
  ),
  City(
    name: 'Mansoura',
    imageUrl:
    'assets/governorates/mansoura.jpg',
    price: 80,
  ),
  City(
    name: 'Ismailia',
    imageUrl:
    'assets/governorates/Ismailia.jpg',
    price: 100,
  ),
  City(
    name: 'Port Said',
    imageUrl:
    'assets/governorates/portsaid.jpg',
    price: 100,
  ),
  City(
    name: 'Cairo',
    imageUrl:
    'assets/governorates/cairo.jpg',
    price: 150,
  ),
  City(
    name: 'El Arish',
    imageUrl:
    'assets/governorates/elarish.jpg',
    price: 200,
  ),
];

Widget HorizontalCitiesList() {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Travel from El-Arish',
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 200, // Set a fixed height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cities.length,
            itemBuilder: (context, index) {
              return CityCard(city: cities[index]);
            },
          ),
        ),
      ],
    ),
  );
}
