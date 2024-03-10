import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vending_machines/views/app/widgets/output_widget.dart';
import 'package:vending_machines/views/homescreen/widgets/product_info_widget.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/vending_machine.dart';

class MachineDetailsScreen extends StatelessWidget {
  final VendingMachine vendingMachine;
  final Product product;
  const MachineDetailsScreen(
      {Key? key, required this.vendingMachine, required this.product})
      : super(key: key);

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
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OutputWidget(text: vendingMachine.name),
              SizedBox(height: 10),
              OutputWidget(text: vendingMachine.location),
              SizedBox(height: 10),
              Text(
                'Machine Types:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Wrap(
                spacing: 6.0,
                children: vendingMachine.machineTypes.map((type) {
                  return Chip(label: Text(type.name.toUpperCase()));
                }).toList(),
              ),
              SizedBox(height: 20),
              ProductInfoWidget(
                  product: product, vendingMachine: vendingMachine)
            ],
          ),
        ),
      ),
    );
  }
}
