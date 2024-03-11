import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vending_machines/views/app/widgets/chosen_action_button_widget.dart';
import 'package:vending_machines/views/machines/views/product_details_screen.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/vending_machine.dart';

class TypeScreen extends StatefulWidget {
  const TypeScreen({Key? key}) : super(key: key);

  @override
  _TypeScreenState createState() => _TypeScreenState();
}

class _TypeScreenState extends State<TypeScreen> {
  List<MachineType> _selectedTypes = [];
  bool _isButtonEnabled = false;
  void _updateButtonStatus() {
    setState(() {
      _isButtonEnabled = _selectedTypes.isNotEmpty;
    });
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
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTypeButton(MachineType.drinks)),
                      Expanded(child: _buildTypeButton(MachineType.food)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildTypeButton(MachineType.media)),
                      Expanded(
                          child: _buildTypeButton(MachineType.merchandise)),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: _buildTypeButton(MachineType.medicine)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              ChosenActionButton(
                  text: 'Next',
                  onTap: _isButtonEnabled
                      ? () {
                          List<VendingMachine> vendingMachinesList =
                              context.read<VendingMachineCubit>().state;
                          int vendingMachineIndex =
                              vendingMachinesList.length - 1;
                          VendingMachine updatedVendingMachine =
                              vendingMachinesList[vendingMachineIndex].copyWith(
                            machineTypes: _selectedTypes,
                          );
                          vendingMachinesList[vendingMachineIndex] =
                              updatedVendingMachine;
                          context
                              .read<VendingMachineCubit>()
                              .updateVendingMachinesList(vendingMachinesList);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProductDetailsScreen()),
                          );
                        }
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please choose a type before continuing.',
                                style: ConstructorTextStyle.snackBar,
                              ),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(MachineType machineType) {
    final isSelected = _selectedTypes.contains(machineType);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedTypes.remove(machineType);
              } else {
                _selectedTypes.add(machineType);
              }
              _updateButtonStatus();
            });
          },
          child: Container(
            //  height: size.height * 0.01,
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.greenColor
                  : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: [
                SizedBox(width: size.width * 0.005),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      machineType.name.toUpperCase(),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: size.width * 0.01),
                  ],
                ),
                Spacer(),
                isSelected
                    ? SvgPicture.asset(
                        'assets/icons/check_circle.svg',
                        width: 24,
                        height: 24,
                      )
                    : SvgPicture.asset(
                        'assets/icons/circle.svg',
                        width: 22,
                        height: 22,
                      ),
                SizedBox(width: size.width * 0.005),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
