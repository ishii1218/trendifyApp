import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_en/widgets/title_text.dart';

import '../../providers/cart_provider.dart';
import '../../providers/products_provider.dart';
import '../../services/my_app_functions.dart';
import '../../widgets/app_name_text.dart';
import '../../widgets/products/heart_btn.dart';
import '../../widgets/subtitle_text.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routName = "/ProductDetailsScreen";
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedSize;

  void showSizeChart(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Size Chart"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              DataTable(
                columnSpacing: 20.0,
                columns: const [
                  DataColumn(label: Text('Size')),
                  DataColumn(label: Text('Chest (in)')),
                  DataColumn(label: Text('Waist (in)')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('S')),
                    DataCell(Text('34-36')),
                    DataCell(Text('28-30')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('M')),
                    DataCell(Text('38-40')),
                    DataCell(Text('32-34')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('L')),
                    DataCell(Text('42-44')),
                    DataCell(Text('36-38')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('XL')),
                    DataCell(Text('46-48')),
                    DataCell(Text('40-42')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('XXL')),
                    DataCell(Text('50-52')),
                    DataCell(Text('44-46')),
                  ]),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productsProvider = Provider.of<ProductsProvider>(context);
    String? productId = ModalRoute.of(context)!.settings.arguments as String?;
    final getCurrProduct = productsProvider.findByProdId(productId!);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
        ),
        title: const AppNameTextWidget(fontSize: 20),
      ),
      body: getCurrProduct == null
          ? const SizedBox.shrink()
          : SingleChildScrollView(
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrProduct.productImage,
                    height: size.height * 0.50,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrProduct.productTitle,
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SubtitleTextWidget(
                              label: "${getCurrProduct.productPrice}\$",
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        // Size dropdown
                        DropdownButtonFormField<String>(
                          value: selectedSize,
                          decoration: const InputDecoration(
                            labelText: "Select Size",
                            border: OutlineInputBorder(),
                          ),
                          items: ["S", "M", "L", "XL", "XXL"]
                              .map((size) => DropdownMenuItem(
                                    value: size,
                                    child: Text(size),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSize = value;
                            });
                          },
                        ),
                        const SizedBox(height: 10),

                        // Size Chart Button
                        TextButton(
                          onPressed: () => showSizeChart(context),
                          child: const Text(
                            "View Size Chart",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeartButtonWidget(
                                bkgColor: Colors.blue.shade100,
                                productId: getCurrProduct.productId,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: kBottomNavigationBarHeight - 10,
                                  child: ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          30.0,
                                        ),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (selectedSize == null) {
                                        // Show warning if size is not selected
                                        await MyAppFunctions
                                            .showErrorOrWarningDialog(
                                          context: context,
                                          subtitle:
                                              "Please select a size before adding to cart.",
                                          fct: () {},
                                        );
                                        return;
                                      }
                                      if (cartProvider.isProdinCart(
                                          productId:
                                              getCurrProduct.productId)) {
                                        return;
                                      }
                                      try {
                                        await cartProvider.addToCartFirebase(
                                            productId: getCurrProduct.productId,
                                            size: selectedSize!,
                                            qty: 1,
                                            context: context);
                                      } catch (e) {
                                        await MyAppFunctions
                                            .showErrorOrWarningDialog(
                                          context: context,
                                          subtitle: e.toString(),
                                          fct: () {},
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      cartProvider.isProdinCart(
                                              productId:
                                                  getCurrProduct.productId)
                                          ? Icons.check
                                          : Icons.add_shopping_cart_outlined,
                                    ),
                                    label: Text(cartProvider.isProdinCart(
                                            productId: getCurrProduct.productId)
                                        ? "In cart"
                                        : "Add to cart"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const TitlesTextWidget(label: "About this item"),
                            SubtitleTextWidget(
                                label: "In ${getCurrProduct.productCategory}"),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SubtitleTextWidget(
                          label: getCurrProduct.productDescription,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
