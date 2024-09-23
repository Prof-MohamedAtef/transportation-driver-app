import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/widgets/white_rounded_home_icon.dart';

Widget LetsGoWidget() {
  return Container(
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s Go!',
          style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16,),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(15),
          ),
          // color: Colors.grey[200],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeIconWithCircle(
                width: 20,
                height: 20,
                iconData: 'assets/images/ic_home_clock.svg',
                iconSize: 15,
                onTap: () {},
                bgColor: Colors.transparent,
              ),
              const Text(
                'Now',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              HomeIconWithCircle(
                width: 20,
                height: 20,
                iconData: 'assets/images/ic_arrow_down.svg',
                iconSize: 15,
                onTap: () {},
                bgColor: Colors.transparent,
              ),
            ],
          ),
        )
      ],
    ),
  );
}