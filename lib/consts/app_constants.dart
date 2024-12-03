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
      id: "Trousers(M)",
      image: AssetsManager.trousers,
      name: "Trousers",
    ),
    CategoriesModel(
      id: "Hoodies",
      image: AssetsManager.hoodie,
      name: "Hoodies",
    ),
    CategoriesModel(
      id: "Shorts(M)",
      image: AssetsManager.shorts,
      name: "Shorts",
    ),
    // CategoriesModel(
    //   id: "Vest",
    //   image: AssetsManager.vest,
    //   name: "Vest",
    // ),
    // CategoriesModel(
    //   id: "Shorts",
    //   image: AssetsManager.shorts,
    //   name: "Shorts",
    // ),
    // CategoriesModel(
    //   id: "Beanie",
    //   image: AssetsManager.beanie,
    //   name: "Beanie",
    // ),
    // CategoriesModel(
    //   id: "Coat",
    //   image: AssetsManager.coat,
    //   name: "Coat",
    // ),
  ];
  static List<CategoriesModel> categoriesListwomen = [
    CategoriesModel(
      id: "Frocks",
      image: AssetsManager.vest,
      name: "Frocks",
    ),
    CategoriesModel(
      id: "Shorts(W)",
      image: AssetsManager.shorts,
      name: "Shorts",
    ),
    CategoriesModel(
      id: "Blouses",
      image: AssetsManager.beanie,
      name: "Blouses",
    ),
    CategoriesModel(
      id: "Trousers(W)",
      image: AssetsManager.coat,
      name: "Trousers",
    ),
  ];
}
