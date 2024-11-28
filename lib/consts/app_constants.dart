import 'package:shopsmart_users_en/models/categories_model.dart';

import '../services/assets_manager.dart';

class AppConstants {
  static const String imageUrl =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2
  ];

  static List<CategoriesModel> categoriesList = [
    CategoriesModel(
      id: "Shirts",
      image: AssetsManager.shirt,
      name: "Shirts",
    ),
    CategoriesModel(
      id: "Trousers",
      image: AssetsManager.trousers,
      name: "Trousers",
    ),
    CategoriesModel(
      id: "Hoodie",
      image: AssetsManager.hoodie,
      name: "Hoodie",
    ),
    CategoriesModel(
      id: "Vest",
      image: AssetsManager.vest,
      name: "Vest",
    ),
    CategoriesModel(
      id: "Shorts",
      image: AssetsManager.shorts,
      name: "Shorts",
    ),
    CategoriesModel(
      id: "Beanie",
      image: AssetsManager.beanie,
      name: "Beanie",
    ),
    CategoriesModel(
      id: "Coat",
      image: AssetsManager.coat,
      name: "Coat",
    ),
  ];
}
