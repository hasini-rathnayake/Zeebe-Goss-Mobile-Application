import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:user_zeebe_app/screens/auth/login.dart'; // Ensure correct import path

class OnboardingPage extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _onBoardingPages = [];

  @override
  void initState() {
    super.initState();
    _onBoardingPages = [
      OnboardingCard(
        image: "assets/images/onbrd11.png",
        title: "Welcome",
        description: 'Welcome to our app. Let\'s get started!',
        buttonText: 'Next',
        onPressed: () {
          _pageController.animateToPage(1,
              duration: Duration(seconds: 1), curve: Curves.linear);
        },
      ),
      OnboardingCard(
        image: "assets/images/onbrd2.png",
        title: "Get Started",
        description: 'Ready to explore?',
        buttonText: 'Done',
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: _onBoardingPages,
              ),
            ),
            SmoothPageIndicator(
              controller: _pageController,
              count: _onBoardingPages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Theme.of(context).colorScheme.secondary,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(index,
                    duration: Duration(seconds: 1), curve: Curves.linear);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  OnboardingCard({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        SizedBox(height: 20),
        (title == "Welcome" || title == "Get Started")
            ? Shimmer.fromColors(
                baseColor: Color.fromARGB(255, 139, 24, 112)!,
                highlightColor: Color.fromARGB(255, 240, 74, 74)!,
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
