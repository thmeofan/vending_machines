import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vending_machines/consts/app_colors.dart';
import 'package:vending_machines/views/app/widgets/chosen_action_button_widget.dart';
import 'package:vending_machines/views/app/widgets/input_widget.dart';
import 'package:vending_machines/views/machines/views/type_screen.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/vending_machine.dart';

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
  }

  void _clearControllers() {
    _nameController.clear();
    _locationController.clear();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColors.purpleColor,
        title: const Text(
          'Back',
          style: ConstructorTextStyle.appBar,
        ),
        titleSpacing: -5,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
      ),
      body: Container(
        color: AppColors.purpleColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              InputWidget(
                controller: _nameController,
                labelText: 'Name',
              ),
              const SizedBox(height: 16.0),
              InputWidget(
                controller: _locationController,
                labelText: 'Location',
              ),
              Spacer(),
              ChosenActionButton(
                text: 'Next',
                onTap: () {
                  if (_nameController.text.isNotEmpty &&
                      _locationController.text.isNotEmpty) {
                    final newVendingMachine = VendingMachine(
                      name: _nameController.text,
                      location: _locationController.text,
                      machineTypes: [],
                      products: [],
                    );
                    context
                        .read<VendingMachineCubit>()
                        .addVendingMachine(newVendingMachine);
                    _clearControllers();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TypeScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please fill in all the fields before continuing.',
                          style: ConstructorTextStyle.snackBar,
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
