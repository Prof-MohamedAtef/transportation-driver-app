import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';
import '../viewmodel/auth/login_user_view_model.dart';
import '../viewmodel/user/user_shared_prefs_view_model.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return drawerWidget(context);
  }
}

Widget drawerWidget(BuildContext context) {
  final authViewModel = Provider.of<LoginAuthViewModel>(context, listen: false);
  final userViewModel = Provider.of<UserViewModel>(context, listen: false);
  userViewModel.loadUser();
  // authViewModel.fetchCurrentUser();
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
                  userViewModel.user?.photoUrl ?? 'assets/images/my_pic.jpg',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                userViewModel.user?.displayName ?? 'Guest',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        if (userViewModel.user?.isVerified == 1)
        ListTile(
          leading: const Icon(Icons.trip_origin),
          title: const Text('Add Drivers'),
          onTap: () {
            // Navigate to the Home page
            Navigator.pushNamed(context, AppRoutes.verificationScreen);
          },
        ),
        // Conditionally show the "Add Trip" tile
        if (userViewModel.user?.isVerified == 1)
          ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Add Trip'),
          onTap: () {
            // Navigate to the Home page
            Navigator.pushNamed(context, AppRoutes.addTripScreen);
          },
        ),

        if (userViewModel.user?.isVerified == 1)
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Add Bus'),
            onTap: () {
              // Navigate to the Home page
              Navigator.pushNamed(context, AppRoutes.addBusScreen);
            },
          ),

        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Update Profile'),
          onTap: () {
            // Navigate to the Home page
            Navigator.pushNamed(context, AppRoutes.updateProfileScreen);
          },
        ),

        ListTile(
          leading: const Icon(Icons.payment),
          title: const Text('Sign Out'),
          onTap: () async {
            // Navigate to the Home page
            await authViewModel.signOut();
            Navigator.pushReplacementNamed(context, AppRoutes.splash);
          },
        ),
      ],
    ),
  );
}
