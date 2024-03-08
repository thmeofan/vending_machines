import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../data/model/vending_machine.dart';
import '../../machines/views/basic_info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMachines = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vending Machine Management'),
      ),
      body: BlocBuilder<VendingMachineCubit, VendingMachine?>(
        builder: (context, vendingMachine) {
          if (vendingMachine == null) {
            return const Center(
              child: Text('No vending machine data available.'),
            );
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showMachines = true;
                      });
                    },
                    child: const Text('Machines'),
                  ),
                  const SizedBox(width: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showMachines = false;
                      });
                    },
                    child: const Text('Products'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: _showMachines
                    ? _buildMachinesList(vendingMachine)
                    : _buildProductsList(vendingMachine),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BasicInfoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMachinesList(VendingMachine vendingMachine) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${vendingMachine.name}'),
                Text('Location: ${vendingMachine.location}'),
                const SizedBox(height: 8.0),
                const Text('Machine Types:'),
                Wrap(
                  spacing: 8.0,
                  children: vendingMachine.machineTypes
                      .map((type) => Chip(label: Text(type.name.toUpperCase())))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsList(VendingMachine vendingMachine) {
    return ListView.builder(
      itemCount: vendingMachine.products.length,
      itemBuilder: (context, index) {
        final product = vendingMachine.products[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${product.name}'),
                Text('Price: ${product.price}'),
                Text('Consumption: ${product.consumption}'),
                Text('Consumption Period: ${product.consumptionPeriod.name}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
