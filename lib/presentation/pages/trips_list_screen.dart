import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripsListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Column(children: [
                Text('11:36 am'),
                Text('12:20 pm')
              ],),
              Column(
                children: [
                  // Blue Circle
                  Container(
                    width: 2.0,
                    height: 2.0,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 2.0), // Spacing

                  // Vertical Line (2dp x 10dp)
                  Container(
                    width: 2.0,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 2.0), // Spacing
                  // Vertical Line (5dp x 20dp)
                  Container(
                    width: 5.0,
                    height: 20.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 2.0), // Spacing

                  // Vertical Line (2dp x 10dp)
                  Container(
                    width: 2.0,
                    height: 10.0,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 2.0), // Spacing

                  // Red Circle
                  Container(
                    width: 2.0,
                    height: 2.0,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.man, color: Colors.pink,),
                      SizedBox(width: 5),
                      Text('22 min')
                    ],
                  ),
                  Text('Abo Rawash Toll Station'),
                  Text('Zamzam Mall (Other Side)'),
                  Row(
                    children: [
                      Icon(Icons.man, color: Colors.pink,),
                      SizedBox(width: 5),
                      Text('3 min')
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Premium', style: TextStyle(color: Colors.green, fontSize: 16),),
                    SizedBox(width: 3,),
                    Text('*'),
                    SizedBox(width: 3,),
                    Text('Bus', style: TextStyle(color: Colors.grey, fontSize: 16)),
                    SizedBox(width: 3,),
                    Text('*'),
                    SizedBox(width: 3,),
                    Text('AC', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
              ),
              Text('39 EGP', style: TextStyle(fontSize: 25, color: Colors.green),)
            ],
          )
        ],
      ),
    );
  }
}