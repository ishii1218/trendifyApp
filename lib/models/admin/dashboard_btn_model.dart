import 'package:flutter/material.dart';
// import 'package:shopsmart_admin_ar/screens/edit_upload_product_form.dart';
// import 'package:shopsmart_admin_ar/screens/inner_screens/orders/orders_screen.dart';
// import 'package:shopsmart_admin_ar/screens/search_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/edit_upload_product_form.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/admin_search_screen.dart';

import 'package:shopsmart_users_en/screens/inner_screen/orders/admin/admin_orders_screen.dart';

import 'package:shopsmart_users_en/services/assets_manager.dart';

// import '../services/assets_manager.dart';

class DashboardButtonsModel {
  final String text, imagePath;
  final Function onPressed;

  DashboardButtonsModel({
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });

  static List<DashboardButtonsModel> dashboardBtnList(BuildContext context) => [
        DashboardButtonsModel(
          text: "Add a new product",
          imagePath: AssetsManager.upload2,
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditOrUploadProductScreen.routeName,
            );
          },
        ),
        DashboardButtonsModel(
          text: "Inspect all products",
          imagePath: AssetsManager.inspect,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AdminSearchScreen.routeName,
            );
          },
        ),
        DashboardButtonsModel(
          text: "View Orders",
          imagePath: AssetsManager.cartlist,
          onPressed: () {
            Navigator.pushNamed(
              context,
              AdminOrdersScreenFree.routeName,
            );
          },
        ),
      ];
}
