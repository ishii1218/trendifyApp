import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_en/models/admin/dashboard_btn_model.dart';
// import 'package:shopsmart_admin_ar/widgets/title_text.dart';
// import 'package:shopsmart_users_en/models/admin/dashboard_btn_model.dart';
import 'package:shopsmart_users_en/providers/theme_provider.dart';
import 'package:shopsmart_users_en/services/assets_manager.dart';
import 'package:shopsmart_users_en/widgets/admin/dashboard_btn.dart';
import 'package:shopsmart_users_en/widgets/title_text.dart';

// import '../models/dashboard_btn_model.dart';
// import '../providers/theme_provider.dart';
// import '../services/assets_manager.dart';
// import '../widgets/dashboard_btn.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/DashboardScreen';
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(label: "Dashboard Screen"),
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(AssetsManager.iconLogo),
        ),
        actions: [
          IconButton(
            onPressed: () {
              themeProvider.setDarkTheme(
                  themeValue: !themeProvider.getIsDarkTheme);
            },
            icon: Icon(themeProvider.getIsDarkTheme
                ? Icons.light_mode
                : Icons.dark_mode),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: DashboardButtonsWidget(
              title:
                  DashboardButtonsModel.dashboardBtnList(context)[index].text,
              imagePath: DashboardButtonsModel.dashboardBtnList(context)[index]
                  .imagePath,
              onPressed: () {
                DashboardButtonsModel.dashboardBtnList(context)[index]
                    .onPressed();
              },
            ),
          ),
        ),
      ),
    );
  }
}
