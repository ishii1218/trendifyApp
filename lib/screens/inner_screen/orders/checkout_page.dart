import 'package:flutter/material.dart';
import 'package:shopsmart_users_en/screens/inner_screen/orders/admin/payment_screen.dart';

class CheckoutPage extends StatelessWidget {
  static const routeName = '/checkout';

  final List<Map<String, dynamic>> orderItems;
  final double totalPrice;

  const CheckoutPage({
    super.key,
    required this.orderItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Order:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orderItems.length,
                itemBuilder: (ctx, index) {
                  final item = orderItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.network(
                        item['imageUrl'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item['productTitle']),
                      subtitle: Text(
                          'Quantity: ${item['quantity']} x ${(item['price'] / item['quantity']).toStringAsFixed(2)} \$'),
                      trailing: Text('${item['price'].toStringAsFixed(2)} \$'),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${totalPrice.toStringAsFixed(2)} \$',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    PaymentScreen.routeName,
                    arguments: {'totalPrice': totalPrice},
                  );
                },
                child: const Text('Proceed to Payment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
