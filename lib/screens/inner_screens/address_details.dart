import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:user_zeebe_app/consts/my_validators.dart';

class AddDeliveryAddress extends StatefulWidget {
  static const routeName = '/AddDeliveryAddress';
  final Function onOrderPlaced;

  const AddDeliveryAddress({super.key, required this.onOrderPlaced});

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  String _selectedPaymentMethod = 'Cash On Delivery';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Checkout', style: textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Insert your details',
                style: textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        hintText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        return MyValidators.displayNamevalidator(value);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _addressController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.streetAddress,
                      decoration: const InputDecoration(
                        hintText: 'Address',
                        prefixIcon: Icon(Icons.home),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _zipcodeController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Zipcode',
                        prefixIcon: Icon(Icons.location_on),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your zipcode';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _mobileController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'Mobile Number',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        return MyValidators.phoneNumberValidator(value);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedPaymentMethod,
                      decoration: const InputDecoration(
                        hintText: 'Select Payment Method',
                        prefixIcon: Icon(Icons.payment),
                      ),
                      items: <String>['Cash On Delivery', 'Card']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedPaymentMethod = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: loading ? null : () => handlePayment(),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handlePayment() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all details correctly'),
        ),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    await Firebase.initializeApp();
    CollectionReference addresses =
        FirebaseFirestore.instance.collection('addresses');

    await addresses.add({
      'name': _nameController.text,
      'address': _addressController.text,
      'zipcode': _zipcodeController.text,
      'mobile': _mobileController.text,
      'paymentMethod': _selectedPaymentMethod,
    });

    setState(() {
      loading = false;
    });

    widget.onOrderPlaced();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Your details have been submitted & Order Confirm'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Done'),
              onPressed: () {
                _formKey.currentState!.reset();
                _nameController.clear();
                _addressController.clear();
                _zipcodeController.clear();
                _mobileController.clear();
                setState(() {
                  _selectedPaymentMethod = 'Cash On Delivery';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
