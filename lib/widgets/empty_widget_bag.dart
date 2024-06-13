import 'package:flutter/material.dart';

import 'package:user_zeebe_app/screens/search_screen.dart';
import 'package:user_zeebe_app/widgets/subtitles_text.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class EmptyBagWidget extends StatelessWidget {
  const EmptyBagWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
  });

  final String imagePath, title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset(
            imagePath,
            width: double.infinity,
            height: size.height * 0.35,
          ),
          const SizedBox(
            height: 20,
          ),
          const TitleTextWidget(
            label: "oops",
            fontSize: 40,
            color: Colors.red,
          ),
          const SizedBox(
            height: 20,
          ),
          SubtitleTextWidget(
            label: title,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SubtitleTextWidget(
              label: subtitle,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
            child: Text(buttonText),
          ),
        ],
      ),
    );
  }
}
