import 'package:flutter/material.dart';

class OnboardingCard extends StatelessWidget {
  final String image, title, description, buttonText;
  final VoidCallback onPressed;

  const OnboardingCard({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.100,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15), // Add some spacing
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          MaterialButton(
            minWidth: 250,
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.primary,
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
