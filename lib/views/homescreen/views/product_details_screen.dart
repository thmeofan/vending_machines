import 'package:flutter/material.dart';
import '../../../data/model/vending_machine.dart';
// Import your Product model

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${product.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}', // Format price to two decimal places
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Consumption: ${product.consumption}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Consumption Period: ${product.consumptionPeriod.name}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality here if needed
              },
              child: Text(
                  'Edit Product'), // You can customize this button as needed
            ),
          ],
        ),
      ),
    );
  }
}
