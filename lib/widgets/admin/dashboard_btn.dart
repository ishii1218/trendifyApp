import 'package:flutter/material.dart';

import 'package:shopsmart_users_en/widgets/subtitle_text.dart';

class DashboardButtonsWidget extends StatelessWidget {
  const DashboardButtonsWidget(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.onPressed});

  final String title, imagePath;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 2,
            ),
            SubtitleTextWidget(
              label: title,
              fontSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
