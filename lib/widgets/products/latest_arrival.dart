import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:shopsmart_users_en/services/assets_manager.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/viewed_recently_provider.dart';
import '../../screens/inner_screen/product_details.dart';
import '../../services/my_app_functions.dart';
import '../subtitle_text.dart';
import 'heart_btn.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProdProvider = Provider.of<ViewedProdProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProdProvider.addViewedProd(productId: productsModel.productId);
          await Navigator.pushNamed(context, ProductDetailsScreen.routName,
              arguments: productsModel.productId);
        },
        child: Container(
          width: size.width * 0.55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.grey[200],
          ),
          child: Stack(
            children: [
              // Product image container
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: FancyShimmerImage(
                    imageUrl: productsModel.productImage,
                    boxFit: BoxFit.fill, // Ensures the entire image is visible
                  ),
                ),
              ),
              // Curved background image at the bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  AssetsManager.largeCardShape, // Path to the curved image
                  fit: BoxFit.cover, // Adjusts the curved shape to fit
                  height: size.height * 0.10,
                ),
              ),

              // Product details overlay inside the curved container
              Positioned(
                bottom: 0, // Ensures the text stays within the curved container
                left: 10,
                right: 10,
                // top: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Product Title
                    Text(
                      productsModel.productTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // const SizedBox(height: 0),
                    // Price
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0), // Add a small gap for visual clarity
                      child: Text(
                        "\$${productsModel.productPrice}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Text(
                    //   "\$${productsModel.productPrice}",
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    // const SizedBox(height: 0),
                    // Heart button and Add to cart button

                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0), // Minimal gap between price and buttons
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeartButtonWidget(
                            productId: productsModel.productId,
                          ),
                          IconButton(
                            onPressed: () async {
                              if (cartProvider.isProdinCart(
                                  productId: productsModel.productId)) {
                                return;
                              }
                              try {
                                await cartProvider.addToCartFirebase(
                                  productId: productsModel.productId,
                                  qty: 1,
                                  size: "N/A",
                                  context: context,
                                );
                              } catch (e) {
                                await MyAppFunctions.showErrorOrWarningDialog(
                                  context: context,
                                  subtitle: e.toString(),
                                  fct: () {},
                                );
                              }
                            },
                            icon: Icon(
                              cartProvider.isProdinCart(
                                productId: productsModel.productId,
                              )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     HeartButtonWidget(
                    //       productId: productsModel.productId,
                    //     ),
                    //     IconButton(
                    //       onPressed: () async {
                    //         if (cartProvider.isProdinCart(
                    //             productId: productsModel.productId)) {
                    //           return;
                    //         }
                    //         try {
                    //           await cartProvider.addToCartFirebase(
                    //             productId: productsModel.productId,
                    //             qty: 1,
                    //             size: "N/A",
                    //             context: context,
                    //           );
                    //         } catch (e) {
                    //           await MyAppFunctions.showErrorOrWarningDialog(
                    //             context: context,
                    //             subtitle: e.toString(),
                    //             fct: () {},
                    //           );
                    //         }
                    //       },
                    //       icon: Icon(
                    //         cartProvider.isProdinCart(
                    //           productId: productsModel.productId,
                    //         )
                    //             ? Icons.check
                    //             : Icons.add_shopping_cart_outlined,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
