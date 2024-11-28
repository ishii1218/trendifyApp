import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String cartId;
  final String productId;
  final int quantity;
  String size;

  CartModel({
    required this.cartId,
    required this.productId,
    required this.quantity,
    this.size = "N/A",
  });
}
