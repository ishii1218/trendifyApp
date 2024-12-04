import 'package:flutter/material.dart';
import 'package:shopsmart_users_en/screens/search_screen.dart';
import 'package:shopsmart_users_en/widgets/subtitle_text.dart';

class CategoryRoundedWidget extends StatelessWidget {
  const CategoryRoundedWidget({
    super.key,
    required this.image,
    required this.name,
    required this.id,
  });

  final String image, name, id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchScreen.routeName, arguments: id);
      },
      child: Column(
        children: [
          Container(
            height: 70, // Increased size of the icon
            width: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade200, // Background color (optional)
              borderRadius: BorderRadius.circular(15), // Curved borders
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SubtitleTextWidget(
            label: name,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
