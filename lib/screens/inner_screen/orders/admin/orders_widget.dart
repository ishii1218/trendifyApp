import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
// import 'package:shopsmart_admin_ar/models/order_model.dart';
import 'package:shopsmart_users_en/models/order_model.dart';
import 'package:shopsmart_users_en/widgets/subtitle_text.dart';
import 'package:shopsmart_users_en/widgets/title_text.dart';
// import '../../../widgets/subtitle_text.dart';
// import '../../../widgets/title_text.dart';

// class AdminOrdersWidgetFree extends StatefulWidget {
//   const AdminOrdersWidgetFree({super.key, required this.ordersModelAdvanced});
//   final OrdersModelAdvanced ordersModelAdvanced;
//   @override
//   State<AdminOrdersWidgetFree> createState() => _OrdersWidgetFreeState();
// }

// class _OrdersWidgetFreeState extends State<AdminOrdersWidgetFree> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: FancyShimmerImage(
//               height: size.width * 0.25,
//               width: size.width * 0.25,
//               imageUrl: widget.ordersModelAdvanced.imageUrl,
//             ),
//           ),
//           Flexible(
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Flexible(
//                         child: TitlesTextWidget(
//                           label: widget.ordersModelAdvanced.productTitle,
//                           maxLines: 2,
//                           fontSize: 15,
//                         ),
//                       ),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.clear,
//                             color: Colors.red,
//                             size: 22,
//                           )),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const TitlesTextWidget(
//                         label: 'Price:  ',
//                         fontSize: 15,
//                       ),
//                       Flexible(
//                         child: SubtitleTextWidget(
//                           label: "${widget.ordersModelAdvanced.price} \$",
//                           fontSize: 15,
//                           color: Colors.blue,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   SubtitleTextWidget(
//                     label: "Qty:${widget.ordersModelAdvanced.quantity}",
//                     fontSize: 15,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   SubtitleTextWidget(
//                     label: "User: ${widget.ordersModelAdvanced.userName}",
//                     fontSize: 15,
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class AdminOrdersWidgetFree extends StatelessWidget {
  final OrdersModelAdvanced ordersModelAdvanced;

  const AdminOrdersWidgetFree({super.key, required this.ordersModelAdvanced});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order ID: ${ordersModelAdvanced.orderId}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text("User: ${ordersModelAdvanced.userName}"),
          Text(
              "Total Price: \$${ordersModelAdvanced.totalPrice.toStringAsFixed(2)}"),
          const SizedBox(height: 8),
          ...ordersModelAdvanced.items.map((item) {
            return Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    height: size.width * 0.25,
                    width: size.width * 0.25,
                    imageUrl: item.imageUrl,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.productTitle, style: TextStyle(fontSize: 16)),
                      Text("Price: \$${item.price.toStringAsFixed(2)}"),
                      Text("Quantity: ${item.quantity}"),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
