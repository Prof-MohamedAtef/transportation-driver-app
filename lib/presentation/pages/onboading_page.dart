import 'package:flutter/material.dart';
import 'package:zeow_driver/presentation/routes/routes.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 3,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
          if (index == 2) {
            Navigator.pushNamed(
                context,
                AppRoutes
                    .signInScreen); // Replace '/signIn' with your actual sign-in route
          }
        },
        itemBuilder: (context, index) {
          return OnboardingPageLayout(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Second',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Third',
          ),
        ],
      ),
    );
  }
}

class OnboardingPageLayout extends StatelessWidget {
  final int index;

  const OnboardingPageLayout(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Onboarding Page ${index + 1}',
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}
