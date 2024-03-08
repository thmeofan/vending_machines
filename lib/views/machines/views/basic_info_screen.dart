import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machines/views/machines/views/type_screen.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';

class BasicInfoScreen extends StatefulWidget {
  const BasicInfoScreen({Key? key}) : super(key: key);

  @override
  _BasicInfoScreenState createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final vendingMachine = context.read<VendingMachineCubit>().state;
    _nameController.text = vendingMachine?.name ?? '';
    _locationController.text = vendingMachine?.location ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Information'),
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
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.read<VendingMachineCubit>().updateBasicInfo(
                      _nameController.text,
                      _locationController.text,
                    );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TypeScreen()),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
