import 'package:flutter/material.dart';

import '../../../data/model/vending_machine.dart';

class MachineDetailsScreen extends StatelessWidget {
  final VendingMachine vendingMachine;

  const MachineDetailsScreen({Key? key, required this.vendingMachine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${vendingMachine.name}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Location: ${vendingMachine.location}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Machine Types:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Wrap(
              spacing: 8.0,
              children: vendingMachine.machineTypes.map((type) {
                return Chip(label: Text(type.name.toUpperCase()));
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality here if needed
              },
              child: Text(
                  'Edit Machine'), // You can customize this button as needed
            ),
          ],
        ),
      ),
    );
  }
}
