import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import 'package:zeow_driver/presentation/viewmodel/auth/auth_viewmodel.dart';

import '../state/auth_state.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return drawerWidget(context);
  }
}

Widget drawerWidget(BuildContext context) {
  final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
  authViewModel.fetchCurrentUser();
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  authViewModel.user?.photoUrl ?? 'assets/images/my_pic.jpg',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                authViewModel.user?.displayName ?? 'Guest',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.trip_origin),
          title: const Text('Verification'),
          onTap: () {
            // Navigate to the Home page
            Navigator.pushNamed(context, AppRoutes.verificationScreen);
          },
        ),
        ListTile(
          leading: const Icon(Icons.wallet),
          title: const Text('Add Vehicle'),
          onTap: () {
            // Navigate to the Home page
            Navigator.pushNamed(context, AppRoutes.addBusScreen);
          },
        ),
        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Add Trip'),
          onTap: () {
            // Navigate to the Home page
            Navigator.pushNamed(context, AppRoutes.addTripScreen);
          },
        ),
      ],
    ),
  );
}
