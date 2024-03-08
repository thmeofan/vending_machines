import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machines/views/machines/views/product_details_screen.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../data/model/vending_machine.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({Key? key}) : super(key: key);

  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  List<MachineType> _selectedTypes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Types'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Select machine types:'),
            const SizedBox(height: 16.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                _buildTypeButton(MachineType.drinks),
                _buildTypeButton(MachineType.food),
                _buildTypeButton(MachineType.media),
                _buildTypeButton(MachineType.merchandise),
                _buildTypeButton(MachineType.medicine),
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context
                    .read<VendingMachineCubit>()
                    .updateMachineTypes(_selectedTypes);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ProductDetailsScreen()),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(MachineType machineType) {
    final isSelected = _selectedTypes.contains(machineType);
    return FilterChip(
      label: Text(machineType.name.toUpperCase()),
      selected: isSelected,
      onSelected: (bool value) {
        setState(() {
          if (value) {
            _selectedTypes.add(machineType);
          } else {
            _selectedTypes.remove(machineType);
          }
        });
      },
    );
  }
}
