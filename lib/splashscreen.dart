import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashscreen';
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation =
        Tween<double>(begin: 0.5, end: 0.6).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 194, 50, 1),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ScaleTransition(
                key: const Key('splashScreen2'),
                scale: _scaleAnimation,
                child: Image.asset(
                  'assets/images/dashboard/fLogo.png',
                  height: 450,
                ),
              ),
            ),
            const Text(
              'Trendify with Us!',
              style: TextStyle(
                fontSize: 28, // Larger text size for emphasis
                fontWeight: FontWeight.bold, // Bold text for visibility
                color: Color.fromRGBO(
                    255, 255, 255, 1), // Elegant green for branding
                letterSpacing: 1.5, // Subtle spacing for a refined appearance
              ),
              textAlign: TextAlign.center, // Align text to the center
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/RegisterScreen');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Color.fromRGBO(0, 208, 98, 1); // Hover color
                    }
                    return Color.fromRGBO(
                        5, 135, 67, 1); // Default button color
                  },
                ),
                fixedSize: MaterialStateProperty.all(
                    const Size(250, 50)), // Button size
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
              ),
              child: const Text(
                'Let\'s Get Started!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for better contrast
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/LoginScreen');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Color.fromRGBO(0, 208, 98, 1); // Hover color
                    }
                    return Color.fromRGBO(
                        5, 135, 67, 1); // Default button color
                  },
                ),
                fixedSize: MaterialStateProperty.all(
                    const Size(250, 50)), // Button size
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ),
              ),
              child: const Text(
                'I Already Have an Account',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text for better contrast
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
