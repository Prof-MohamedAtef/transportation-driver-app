import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/widgets/white_rounded_home_icon.dart';
import 'package:flutter_svg/svg.dart';

Widget AddHomeWidget() {
  return Padding(
    padding: const EdgeInsets.all(16.0), // Adds padding to the entire Row
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            HomeIconWithCircle(
              width: 30,
              height: 30,
              iconData: 'assets/images/ic_home.svg',
              iconSize: 20,
              onTap: () {},
              bgColor: Colors.green[50],
            ),
            const SizedBox(width: 10),
            const Text(
              'Add Home Address',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SvgPicture.asset(
          'assets/images/ic_add_btn.svg',
          height: 20,
          width: 20,
        ),
      ],
    ),
  );
}