import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:shopsmart_admin_ar/providers/order_provider.dart';
import 'package:shopsmart_users_en/models/order_model.dart';
import 'package:shopsmart_users_en/providers/admin/admin_order_provider.dart';
import 'package:shopsmart_users_en/services/assets_manager.dart';
import 'package:shopsmart_users_en/widgets/empty_bag.dart';
import 'package:shopsmart_users_en/widgets/title_text.dart';
// import '../../../models/order_model.dart';
// import '../../../widgets/title_text.dart';
import 'orders_widget.dart';

class AdminOrdersScreenFree extends StatefulWidget {
  static const routeName = '/AdminOrderScreen';

  const AdminOrdersScreenFree({super.key});

  @override
  State<AdminOrdersScreenFree> createState() => _AdminOrdersScreenFreeState();
}

class _AdminOrdersScreenFreeState extends State<AdminOrdersScreenFree> {
  late Future<List<OrdersModelAdvanced>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    final ordersProvider =
        Provider.of<AdminOrderProvider>(context, listen: false);
    _ordersFuture = ordersProvider.fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        future: _ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 50, color: Colors.red),
                  SizedBox(height: 10),
                  Text(
                    'Unable to load orders. Please try again later.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "No orders have been placed yet",
              subtitle: "",
              buttonText: "Shop now",
              onPressed: () {
                Navigator.pushNamed(context, "/SearchScreen");
              },
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('Something went wrong. Please try again later.'),
            );
          }

          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                child: AdminOrdersWidgetFree(
                  ordersModelAdvanced: snapshot.data![index],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}


// class AdminOrdersScreenFree extends StatefulWidget {
//   static const routeName = '/AdminOrderScreen';

//   const AdminOrdersScreenFree({super.key});

//   @override
//   State<AdminOrdersScreenFree> createState() => _AdminOrdersScreenFree();
// }

// class _AdminOrdersScreenFree extends State<AdminOrdersScreenFree> {
//   @override
//   Widget build(BuildContext context) {
//     final ordersProvider = Provider.of<AdminOrderProvider>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const TitlesTextWidget(
//           label: 'Placed Orders',
//         ),
//       ),
//       body: FutureBuilder<List<OrdersModelAdvanced>>(
//         future: ordersProvider.fetchOrder(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             debugPrint("Error loading orders: ${snapshot.error}");
//             return Center(
//               child: SelectableText("Error: ${snapshot.error}"),
//             );
//           } else if (snapshot.hasData && snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('No orders have been placed yet'),
//             );
//           }
//           return ListView.separated(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (ctx, index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
//                 child: AdminOrdersWidgetFree(
//                   ordersModelAdvanced: snapshot.data![index],
//                 ),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return const Divider();
//             },
//           );
//         },
//       ),
//     );
//   }
// }







// class _OrdersScreenFreeState extends State<AdminOrdersScreenFree> {
//   @override
//   Widget build(BuildContext context) {
//     final ordersProvider = Provider.of<AdminOrderProvider>(context);
//     return Scaffold(
//         appBar: AppBar(
//           title: const TitlesTextWidget(
//             label: 'Placed orders',
//           ),
//         ),
//         body: FutureBuilder<List<OrdersModelAdvanced>>(
//           future: ordersProvider.fetchOrder(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: SelectableText(snapshot.error.toString()),
//               );
//             }
//             return ListView.separated(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (ctx, index) {
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
//                   child: AdminOrdersWidgetFree(
//                       ordersModelAdvanced: ordersProvider.getOrders[index]),
//                 );
//               },
//               separatorBuilder: (BuildContext context, int index) {
//                 return const Divider(
//                     // thickness: 8,
//                     // color: Colors.red,
//                     );
//               },
//             );
//           },
//         ));
//   }
// }
