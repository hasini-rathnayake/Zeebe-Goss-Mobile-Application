import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_zeebe_app/widgets/titles_text.dart';

class AppNameTextWidget extends StatelessWidget {
  final double fontSize;
  const AppNameTextWidget({super.key, this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 16),
      baseColor: Color.fromARGB(255, 97, 29, 107),
      highlightColor: Color.fromARGB(255, 255, 52, 52),
      child: TitleTextWidget(
        label: "ZEEBE GOSS",
        fontSize: 35,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
