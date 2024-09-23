import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/widgets/white_rounded_home_icon.dart';

Widget CurrentWhereWidget() {
  return Container(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HomeIconWithCircle(
                width: 20,
                height: 20,
                iconData: 'assets/images/ic_navigation.svg',
                iconSize: 15,
                onTap: () {},
                bgColor: Colors.transparent,
              ),
              const Text(
                'My current location',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 34),
            child: Divider(thickness: 1, color: Colors.grey[300],),
          ),
          const SizedBox(
            height: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 13, top: 5, bottom: 3),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 17,),
                Text(
                  'Where to?',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
