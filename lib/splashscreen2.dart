import 'package:flutter/material.dart';

class SplashScreen2 extends StatelessWidget {
  static const routeName = '/splashscreen2';
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Previous Page')),
      body: const Center(child: Text('Welcome to the next page!')),
    );
  }
}
