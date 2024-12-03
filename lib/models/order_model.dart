// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:shopsmart_users_en/models/order_Item.dart';

// class OrdersModelAdvanced with ChangeNotifier {
//   // final String orderId;
//   // final String userId;
//   // final String productId;
//   // final String productTitle;
//   // final String userName;
//   // final String price;
//   // final String imageUrl;
//   // final String quantity;
//   // final Timestamp orderDate;

//   // OrdersModelAdvanced(
//   //     {required this.orderId,
//   //     required this.userId,
//   //     required this.productId,
//   //     required this.productTitle,
//   //     required this.userName,
//   //     required this.price,
//   //     required this.imageUrl,
//   //     required this.quantity,
//   //     required this.orderDate});

//   final String orderId;
//   final String userId;
//   final String userName;
//   final double totalPrice;
//   final List<OrderItem> items;
//   final Timestamp orderDate;

//   OrdersModelAdvanced({
//     required this.orderId,
//     required this.userId,
//     required this.userName,
//     required this.totalPrice,
//     required this.items,
//     required this.orderDate, required imageUrl, required String quantity, required productTitle, required String price, required productId,
//   });

//   factory OrdersModelAdvanced.fromFirestore(Map<String, dynamic> data) {
//     return OrdersModelAdvanced(
//       orderId: data['orderId'],
//       userId: data['userId'],
//       userName: data['userName'],
//       totalPrice: data['totalPrice'].toDouble(),
//       items: (data['items'] as List<dynamic>)
//           .map((item) => OrderItem.fromMap(item))
//           .toList(),
//       orderDate: data['orderDate'],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'orderId': orderId,
//       'userId': userId,
//       'userName': userName,
//       'totalPrice': totalPrice,
//       'items': items.map((item) => item.toMap()).toList(),
//       'orderDate': orderDate,
//     };
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String productId;
  final String productTitle;
  final double price;
  final int quantity;
  final String imageUrl;

  OrderItem({
    required this.productId,
    required this.productTitle,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['productId'],
      productTitle: map['productTitle'],
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble() // Convert int to double
          : (map['price'] ?? 0.0), // Handle null or already double
      quantity: map['quantity'],
      imageUrl: map['imageUrl'],
    );
  }
}

class OrdersModelAdvanced {
  final String orderId;
  final String userId;
  final List<OrderItem> items;
  final double totalPrice;
  final String userName;
  final Timestamp orderDate;

  OrdersModelAdvanced({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.userName,
    required this.orderDate,
  });

  factory OrdersModelAdvanced.fromMap(Map<String, dynamic> map) {
    try {
      // Print raw data for debugging
      debugPrint('Raw Order Data: $map');

      return OrdersModelAdvanced(
        orderId: map['orderId'] ?? '',
        userId: map['userId'] ?? '',
        items: (map['items'] as List<dynamic>)
            .map((item) => OrderItem.fromMap(item))
            .toList(),
        totalPrice:
            (map['totalPrice'] as num).toDouble(), // Safely cast to double
        userName: map['userName'] ?? '',
        orderDate: map['orderDate'] ?? Timestamp.now(),
      );
    } catch (e) {
      // Print error details for debugging
      debugPrint('Error in OrdersModelAdvanced.fromMap: $e');
      rethrow; // Re-throw the error for visibility
    }
  }
}
