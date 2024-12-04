import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/payment';

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late String _paymentStatus;

  @override
  void initState() {
    super.initState();
    _paymentStatus = "Awaiting Payment...";

    // Set the publishable key for Stripe
    Stripe.publishableKey =
        'pk_test_51PRWiNP2j6GyuA7Txuu5OLDVqCbhkBHJS1vsZmIqs8ruadbfnYftQTUd6xYtr1Y5NtfY1MzKwYu5poX50SwFcb9s00qRJ4Ftu6'; // Use your Stripe publishable key here
  }

  Future<void> _startPayment(double totalPrice) async {
    try {
      // Create a PaymentIntent
      final paymentIntent = await _createPaymentIntent(totalPrice);

      // Use PaymentIntent client_secret to confirm the payment
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Trendify',
        ),
      );

      // Present the PaymentSheet
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        _paymentStatus = "Payment Successful!";
      });
    } catch (e) {
      setState(() {
        _paymentStatus = "Payment Failed: $e";
      });
      print('Error: $e');
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(double amount) async {
    // Simulated PaymentIntent creation (In production, create this in a backend)
    // The amount must be in cents for Stripe (e.g., $10.99 -> 1099)
    return {
      'client_secret':
          'sk_test_51PRWiNP2j6GyuA7TRujnre7fUnTF0Ahsy83NI4pljtXA3HCTUoF961mYjk8CJ7L9Myfnd1V0ofhbtvrgEYOOUwiA00RXpJ4I3g', // Replace this with a real client_secret in production
    };
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final totalPrice = args['totalPrice'] as double;

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Amount: \$${totalPrice.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _startPayment(totalPrice),
              child: const Text("Pay with Stripe"),
            ),
            const SizedBox(height: 20),
            Text(
              _paymentStatus,
              style: TextStyle(
                fontSize: 16,
                color: _paymentStatus.contains("Successful")
                    ? Colors.green
                    : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
