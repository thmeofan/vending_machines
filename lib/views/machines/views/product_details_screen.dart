import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../data/model/vending_machine.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _consumptionController = TextEditingController();
  ConsumptionPeriod _consumptionPeriod = ConsumptionPeriod.daily;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _consumptionController,
              decoration: const InputDecoration(
                labelText: 'Consumption',
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Consumption Period:'),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildConsumptionPeriodButton(ConsumptionPeriod.daily),
                _buildConsumptionPeriodButton(ConsumptionPeriod.weekly),
                _buildConsumptionPeriodButton(ConsumptionPeriod.monthly),
                _buildConsumptionPeriodButton(ConsumptionPeriod.annually),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final product = Product(
                  name: _nameController.text,
                  price: double.parse(_priceController.text),
                  consumption: _consumptionController.text,
                  consumptionPeriod: _consumptionPeriod,
                );
                context.read<VendingMachineCubit>().addProduct(product);
                _nameController.clear();
                _priceController.clear();
                _consumptionController.clear();
              },
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsumptionPeriodButton(ConsumptionPeriod consumptionPeriod) {
    final isSelected = _consumptionPeriod == consumptionPeriod;
    return FilterChip(
      label: Text(consumptionPeriod.name.toUpperCase()),
      selected: isSelected,
      onSelected: (bool value) {
        setState(() {
          _consumptionPeriod = value ? consumptionPeriod : _consumptionPeriod;
        });
      },
    );
  }
}