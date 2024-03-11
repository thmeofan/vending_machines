import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vending_machines/views/app/widgets/input_widget.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/vending_machine.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../homescreen/views/home_screen.dart';

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

  bool _validateAndSaveProduct() {
    final String name = _nameController.text;
    final String priceString = _priceController.text;
    final String consumption = _consumptionController.text;

    if (name.isEmpty || priceString.isEmpty || consumption.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields before adding the product.',
            style: ConstructorTextStyle.snackBar,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    double? price = double.tryParse(priceString);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter a valid price.',
            style: ConstructorTextStyle.snackBar,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }

    final product = Product(
      name: name,
      price: price,
      consumption: consumption,
      consumptionPeriod: _consumptionPeriod,
    );

    List<VendingMachine> vendingMachinesList =
        context.read<VendingMachineCubit>().state;
    int vendingMachineIndex = vendingMachinesList.length - 1;
    VendingMachine updatedVendingMachine =
        vendingMachinesList[vendingMachineIndex].copyWith(
      products: [...vendingMachinesList[vendingMachineIndex].products, product],
    );
    vendingMachinesList[vendingMachineIndex] = updatedVendingMachine;
    context
        .read<VendingMachineCubit>()
        .updateVendingMachinesList(vendingMachinesList);

    _nameController.clear();
    _priceController.clear();
    _consumptionController.clear();
    return true;
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
              InputWidget(controller: _nameController, labelText: 'Name'),
              const SizedBox(height: 16.0),
              InputWidget(
                controller: _priceController,
                labelText: 'Price',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              InputWidget(
                controller: _consumptionController,
                labelText: 'Consumption',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Consumption Period:',
                    style: ConstructorTextStyle.title,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child:
                        _buildConsumptionPeriodButton(ConsumptionPeriod.daily),
                  ),
                  Expanded(
                    child:
                        _buildConsumptionPeriodButton(ConsumptionPeriod.weekly),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildConsumptionPeriodButton(
                        ConsumptionPeriod.monthly),
                  ),
                  Expanded(
                    child: _buildConsumptionPeriodButton(
                        ConsumptionPeriod.annually),
                  ),
                ],
              ),
              Spacer(),
              ChosenActionButton(
                onTap: () {
                  if (_validateAndSaveProduct()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Product saved successfully!',
                          style: ConstructorTextStyle.snackBar,
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                text: 'Add product',
              ),
              ChosenActionButton(
                onTap: () {
                  if (_validateAndSaveProduct()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                    );
                  }
                },
                text: 'Done',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConsumptionPeriodButton(ConsumptionPeriod consumptionPeriod) {
    final isSelected = _consumptionPeriod == consumptionPeriod;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.08,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: InkWell(
          onTap: () {
            setState(() {
              _consumptionPeriod = consumptionPeriod;
            });
          },
          child: Container(
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
                      consumptionPeriod.name.toUpperCase(),
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
