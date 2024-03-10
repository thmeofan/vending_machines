import 'package:flutter/material.dart';

import '../../../data/model/vending_machine.dart'; // Import your models here

class ProductInfoWidget extends StatelessWidget {
  final Product product;
  final VendingMachine vendingMachine;

  const ProductInfoWidget({
    Key? key,
    required this.product,
    required this.vendingMachine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                vendingMachine.machineTypes.first.name,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            'Price: ${product.price}',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Icon(Icons.access_time),
              SizedBox(width: 5.0),
              Text(
                'Renew: ${_calculateRenewDate()}',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateRenewDate() {
    DateTime currentDate = DateTime.now();
    int daysToAdd = 0;
    switch (product.consumptionPeriod) {
      case ConsumptionPeriod.daily:
        daysToAdd = 1;
        break;
      case ConsumptionPeriod.weekly:
        daysToAdd = 7;
        break;
      case ConsumptionPeriod.monthly:
        daysToAdd = 30;
        break;
      case ConsumptionPeriod.annually:
        daysToAdd = 365;
        break;
    }
    DateTime renewDate = currentDate.add(Duration(days: daysToAdd));
    return '${renewDate.day}/${renewDate.month}/${renewDate.year}';
  }
}
