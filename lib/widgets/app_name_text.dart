import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopsmart_users_en/widgets/title_text.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize = 30});
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 10),
      baseColor: Color.fromARGB(255, 207, 181, 59),
      highlightColor: Color.fromARGB(255, 80, 200, 120),
      child: TitlesTextWidget(
        label: "Trendify",
        fontSize: fontSize,
      ),
    );
  }
}
