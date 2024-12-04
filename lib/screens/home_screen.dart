import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_en/consts/app_constants.dart';
import 'package:shopsmart_users_en/providers/products_provider.dart';
import 'package:shopsmart_users_en/widgets/caraousel/slider.dart';
import 'package:shopsmart_users_en/widgets/products/ctg_rounded_widget.dart';
import 'package:shopsmart_users_en/widgets/products/latest_arrival.dart';

import '../services/assets_manager.dart';
import '../widgets/app_name_text.dart';
import '../widgets/title_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image.asset(
            AssetsManager.iconLogo,
          ),
        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeaderCarousel(
                imagePaths: AppConstants.bannersImages,
              ),

              // const SizedBox(
              //   height: 15,
              // ),
              // SizedBox(
              //   height: size.height * 0.25,
              //   child: ClipRRect(
              //     // borderRadius: BorderRadius.circular(50),
              //     child: Swiper(
              //       autoplay: true,
              //       itemBuilder: (BuildContext context, int index) {
              //         return Image.asset(
              //           AppConstants.bannersImages[index],
              //           fit: BoxFit.fill,
              //         );
              //       },
              //       itemCount: AppConstants.bannersImages.length,
              //       pagination: const SwiperPagination(
              //         // alignment: Alignment.center,
              //         builder: DotSwiperPaginationBuilder(
              //             activeColor: Colors.red, color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 10.0,
              ),
              Visibility(
                visible: productsProvider.getProducts.isNotEmpty,
                child: const TitlesTextWidget(label: "Latest arrivals"),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Visibility(
                visible: productsProvider.getProducts.isNotEmpty,
                child: SizedBox(
                  height: size.height * 0.35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: productsProvider.getProducts.length < 10
                          ? productsProvider.getProducts.length
                          : 10,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: productsProvider.getProducts[index],
                            child: const LatestArrivalProductsWidget());
                      }),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const TitlesTextWidget(label: "Men's Section"),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.99,
                  children: List.generate(AppConstants.categoriesList.length,
                      (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].image,
                      name: AppConstants.categoriesList[index].name,
                      id: AppConstants.categoriesList[index].id,
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              const TitlesTextWidget(label: "Women's Section"),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.99,
                  children: List.generate(
                      AppConstants.categoriesListwomen.length, (index) {
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesListwomen[index].image,
                      name: AppConstants.categoriesListwomen[index].name,
                      id: AppConstants.categoriesListwomen[index].id,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
