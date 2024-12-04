import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_address.dart'; // Import your Address model

class AddressFormPage extends StatefulWidget {
  static const routeName = '/addressform';

  @override
  _AddressFormPageState createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();

  // Load existing address if available
  Future<void> _loadExistingAddress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Fetch the existing address from Firestore
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('addresses')
          .limit(1) // Assuming only one address for simplicity
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        final addressData = docSnapshot.docs.first.data();
        setState(() {
          _streetController.text = addressData['street'] ?? '';
          _cityController.text = addressData['city'] ?? '';
          _stateController.text = addressData['state'] ?? '';
          _postalCodeController.text = addressData['postalCode'] ?? '';
        });
      }
    }
  }

  // Save the address to Firestore
  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      // Create Address object
      final address = Address(
        street: _streetController.text,
        city: _cityController.text,
        state: _stateController.text,
        postalCode: _postalCodeController.text,
      );

      // Get current user
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final addressRef = FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('addresses');

        // Check if an address already exists
        final existingAddressSnapshot = await addressRef.limit(1).get();

        if (existingAddressSnapshot.docs.isNotEmpty) {
          // Update existing address
          await addressRef
              .doc(existingAddressSnapshot.docs.first.id)
              .set(address.toMap());
        } else {
          // Add new address
          await addressRef.add(address.toMap());
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Address saved successfully!')),
        );

        Navigator.pop(context); // Go back after saving
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User not logged in')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadExistingAddress(); // Load the existing address when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shipping Address')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _streetController,
                decoration: InputDecoration(labelText: 'Street'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter street';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter city';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(labelText: 'State'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Enter state';
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _postalCodeController,
                decoration: InputDecoration(labelText: 'Postal Code'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Enter postal code';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveAddress,
                child: Text('Save Address'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
