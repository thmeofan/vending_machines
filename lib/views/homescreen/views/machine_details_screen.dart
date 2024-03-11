import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vending_machines/consts/app_text_styles/home_screen_text_style.dart';
import 'package:vending_machines/views/app/widgets/output_widget.dart';
import 'package:vending_machines/views/homescreen/widgets/product_info_widget.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/vending_machine.dart';
import '../../machines/views/product_details_screen.dart';

class MachineDetailsScreen extends StatelessWidget {
  final VendingMachine vendingMachine;
  const MachineDetailsScreen({
    Key? key,
    required this.vendingMachine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              SizedBox(height: size.height * 0.015),
              OutputWidget(text: vendingMachine.location),
              SizedBox(height: size.height * 0.015),
              Row(
                children: [
                  const Text(
                    'Products:',
                    style: HomeScreenTextStyle.products,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Add more',
                      style: TextStyle(
                        color: AppColors.greenColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: vendingMachine.products.map((product) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ProductInfoWidget(
                        product: product,
                        vendingMachine: vendingMachine,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
