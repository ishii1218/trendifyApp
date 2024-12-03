import 'package:flutter/material.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> categoriesList = [
    'Shorts(M)',
    'Trousers(M)',
    'Shirts',
    'Hoodies',
  ];
  static List<String> categoriesListwomen = [
    'Frocks',
    'Shorts(W)',
    'Blouses',
    'Trousers(W)',
  ];
  static List<String> categoriesListTot = [
    ...categoriesList,
    ...categoriesListwomen,
  ];

  static List<DropdownMenuItem<String>>? get categoriesDropDownList {
    List<DropdownMenuItem<String>>? menuItems =
        List<DropdownMenuItem<String>>.generate(
      categoriesListTot.length,
      (index) => DropdownMenuItem(
        value: categoriesListTot[index],
        child: Text(
          categoriesListTot[index],
        ),
      ),
    );
    return menuItems;
  }
}
