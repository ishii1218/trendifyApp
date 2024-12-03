// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// // import 'package:shopsmart_admin_ar/models/order_model.dart';
// import 'package:shopsmart_users_en/models/order_model.dart';

// class AdminOrderProvider with ChangeNotifier {
//   final List<OrdersModelAdvanced> orders = [];
//   List<OrdersModelAdvanced> get getOrders => orders;

//   Future<List<OrdersModelAdvanced>> fetchOrder() async {
//     // final auth = FirebaseAuth.instance;
//     // User? user = auth.currentUser;
//     // var uid = user!.uid;
//     try {
//       await FirebaseFirestore.instance
//           .collection("ordersAdvanced")
//           .orderBy("orderDate", descending: false)
//           .get()
//           .then((orderSnapshot) {
//         orders.clear();
//         for (var element in orderSnapshot.docs) {
//           orders.insert(
//             0,
//             OrdersModelAdvanced(
//               orderId: element.get('orderId'),
//               productId: element.get('productId'),
//               userId: element.get('userId'),
//               price: element.get('price').toString(),
//               productTitle: element.get('productTitle').toString(),
//               quantity: element.get('quantity').toString(),
//               imageUrl: element.get('imageUrl'),
//               userName: element.get('userName'),
//               orderDate: element.get('orderDate'),
//             ),
//           );
//         }
//       });
//       return orders;
//     } catch (e) {
//       rethrow;
//     }
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopsmart_users_en/models/order_model.dart';

class AdminOrderProvider with ChangeNotifier {
  final List<OrdersModelAdvanced> orders = [];
  List<OrdersModelAdvanced> get getOrders => orders;

  Future<List<OrdersModelAdvanced>> fetchOrder() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection("ordersAdvanced")
          .orderBy("orderDate", descending: false)
          .get();

      orders.clear();
      for (var element in querySnapshot.docs) {
        // Parse each document into an OrdersModelAdvanced
        orders.add(
          OrdersModelAdvanced(
            orderId: element.get('orderId'),
            userId: element.get('userId'),
            items: (element.get('items') as List<dynamic>)
                .map((item) => OrderItem.fromMap(item as Map<String, dynamic>))
                .toList(),
            totalPrice: element.get('totalPrice').toDouble(),
            userName: element.get('userName'),
            orderDate: element.get('orderDate'),
          ),
        );
      }
      notifyListeners();
      return orders;
    } catch (e) {
      rethrow;
    }
  }
}
