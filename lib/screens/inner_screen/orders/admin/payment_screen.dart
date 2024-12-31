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

    Stripe.publishableKey =
        'pk_test_51PRWiNP2j6GyuA7Txuu5OLDVqCbhkBHJS1vsZmIqs8ruadbfnYftQTUd6xYtr1Y5NtfY1MzKwYu5poX50SwFcb9s00qRJ4Ftu6'; // Use your Stripe publishable key here
  }

  Future<void> _startPayment(double totalPrice) async {
    try {
      final paymentIntent = await _createPaymentIntent(totalPrice);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['client_secret'],
          merchantDisplayName: 'Trendify',
        ),
      );

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
    return {
      'client_secret':
          'sk_test_51PRWiNP2j6GyuA7TRujnre7fUnTF0Ahsy83NI4pljtXA3HCTUoF961mYjk8CJ7L9Myfnd1V0ofhbtvrgEYOOUwiA00RXpJ4I3g', // Replace this with a real client_secret in production
    };
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final totalPrice = args['totalPrice'] as double;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure Payment"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.payment,
                  size: 80,
                  color: Color.fromARGB(255, 207, 181, 59),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () => _startPayment(totalPrice),
                  icon: const Icon(Icons.credit_card),
                  label: const Text("Pay with Stripe"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                    backgroundColor: const Color.fromARGB(255, 238, 238, 238),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _paymentStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _paymentStatus.contains("Successful")
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
