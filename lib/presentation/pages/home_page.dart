import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zeow_driver/presentation/viewmodel/user/user_shared_prefs_view_model.dart';
import 'package:zeow_driver/presentation/widgets/current_where_widget.dart';
import 'package:zeow_driver/presentation/widgets/my_drawer_widget.dart';
import '../widgets/add_home_widget.dart';
import '../widgets/category_timing_selection.dart';
import '../widgets/cities_widget.dart';
import '../widgets/greetings_widget.dart';
import '../widgets/home_card_widget.dart';
import '../widgets/lets_go_widget.dart';
import '../widgets/submit_button.dart';
import '../widgets/white_rounded_home_icon.dart';
import '../widgets/white_rounded_icon.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Builder(builder: (ctx) {
            return IconWithCircle(
                iconData: Icons.menu,
                iconSize: 25,
                onTap: () {
                  Scaffold.of(ctx).openDrawer();
                });
          }),
        ),
        title: GreetingsWidget(
          name: userViewModel.user?.displayName ?? 'Guest',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.green[50],
                padding: const EdgeInsets.only(bottom: 20),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedContainerWithImage(
                        imageUrl: 'assets/images/swvlhomecart.png'),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HomeCategorySelection(),
                          HomeCategorySelection(),
                          HomeCategorySelection(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LetsGoWidget(),
              const SizedBox(
                height: 10,
              ),
              CurrentWhereWidget(),
              const SizedBox(
                height: 5,
              ),

              AddHomeWidget(),
              Divider(thickness: 7, color: Colors.green[50],),
              const SizedBox(
                height: 10,
              ),
              HorizontalCitiesList(),
              const SubmitButton(),
            ],
          ),
        ),
      ),
      drawer: const MyDrawerWidget(),
    );
  }
}