import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomHeaderCarousel extends StatefulWidget {
  final List<String> imagePaths;

  const CustomHeaderCarousel({super.key, required this.imagePaths});

  @override
  _CustomHeaderCarouselState createState() => _CustomHeaderCarouselState();
}

class _CustomHeaderCarouselState extends State<CustomHeaderCarousel> {
  int _currentIndex = 0;
  bool _isHovered = false; // State for hover effect

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Carousel slider for the background images
        SizedBox(
          height: 280,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 11,
              viewportFraction: 1.0,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: widget.imagePaths.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  );
                },
              );
            }).toList(),
          ),
        ),

        // Dark overlay layer to darken the image
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ),

        // Overlay content
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 5),
                // Icons (menu and notifications)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
                const Spacer(),
                // Text overlay
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Summer COLLECTION",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "40% OFF",
                      style: TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "For Selected collection",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // "Shop Now" button with hover effect
                MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovered = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovered = false;
                    });
                  },
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isHovered ? Colors.blue : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context,
                          "/SearchScreen"); // Navigate to the search screen
                    },
                    child: Text(
                      "Shop Now",
                      style: TextStyle(
                        color: _isHovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Dots (paginator)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imagePaths.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        _currentIndex = entry.key;
                      }),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 4.0,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == entry.key
                              ? Colors.white
                              : Colors.grey,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
