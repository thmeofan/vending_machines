import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machines/views/app/widgets/chosen_action_button_widget.dart';
import 'package:vending_machines/views/homescreen/views/product_screen.dart';
import 'package:vending_machines/views/homescreen/widgets/banner_widget.dart';

import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/vending_machine.dart';
import '../../../util/app_routes.dart';
import '../../machines/views/basic_info_screen.dart';
import '../../machines/views/product_details_screen.dart';
import 'machine_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showMachines = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.purpleColor,
          leadingWidth: size.width * 0.3,
          leading: TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.profile,
              );
            },
            child: const Text(
              'Settings',
              style: HomeScreenTextStyle.appbar,
            ),
          ),
        ),
        body: Container(
          color: AppColors.purpleColor,
          child: BlocBuilder<VendingMachineCubit, List<VendingMachine>>(
            builder: (context, vendingMachinesList) {
              if (vendingMachinesList.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      OperationBanner(),
                      SizedBox(height: size.height * 0.08),
                      Text('No vending machine data available.'),
                      Spacer(),
                      ChosenActionButton(
                        text: 'Add Machines',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const BasicInfoScreen()),
                          );
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  OperationBanner(),
                  SizedBox(height: size.height * 0.03),
                  Expanded(
                    child: Container(
                      // height: size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showMachines = true;
                                });
                              },
                              style: _showMachines
                                  ? ElevatedButton.styleFrom(
                                      primary: AppColors.greenColor)
                                  : null,
                              child: const Text('Machines'),
                            ),
                            const SizedBox(width: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _showMachines = false;
                                });
                              },
                              style: !_showMachines
                                  ? ElevatedButton.styleFrom(
                                      primary: AppColors.greenColor)
                                  : null,
                              child: const Text('Products'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: _showMachines
                              ? _buildMachinesList(vendingMachinesList)
                              : _buildProductsList(
                                  context,
                                  vendingMachinesList
                                      .expand((machine) => machine.products)
                                      .toList()),
                        ),
                        ChosenActionButton(
                          text: 'Add Machines',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const BasicInfoScreen()),
                            );
                          },
                        ),
                        SizedBox(height: size.height * 0.03),
                      ]),
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }

  Widget _buildMachinesList(List<VendingMachine> vendingMachines) {
    return ListView.builder(
      itemCount: vendingMachines.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MachineDetailsScreen(
                    vendingMachine: vendingMachines[index],
                    product: vendingMachines
                        .expand((machine) => machine.products) as Product),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white.withOpacity(0.25),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(vendingMachines[index].name),
                        const SizedBox(width: 8.0),
                        Wrap(
                          spacing: 8.0,
                          children: vendingMachines[index]
                              .machineTypes
                              .map((type) =>
                                  Chip(label: Text(type.name.toUpperCase())))
                              .toList(),
                        ),
                      ],
                    ),
                    Text(vendingMachines[index].location),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductsList(BuildContext context, List<Product> products) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductScreen(product: product),
              ),
            );
          },
          child: Card(
            color: Colors.white.withOpacity(0.25),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name),
                  Text(product.price.toString()),
                  Text(product.consumption),
                  Text(product.consumptionPeriod.name),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
