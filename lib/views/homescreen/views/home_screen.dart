import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machines/views/app/widgets/chosen_action_button_widget.dart';
import 'package:vending_machines/views/homescreen/widgets/banner_widget.dart';
import '../../../blocs/vending_machine_cubit/vending_machine_cubit.dart';
import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/vending_machine.dart';
import '../../../util/app_routes.dart';
import '../../machines/views/basic_info_screen.dart';
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
                      const MachineBanner(),
                      SizedBox(height: size.height * 0.08),
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              SizedBox(height: size.height * 0.1),
                              const Text(
                                'No vending machine data available.',
                                style: HomeScreenTextStyle.banner,
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              ChosenActionButton(
                                text: 'Add Machines',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            const BasicInfoScreen()),
                                  );
                                },
                              ),
                              SizedBox(height: size.height * 0.03),
                            ])),
                      )
                    ],
                  ),
                );
              }

              return Column(
                children: [
                  const MachineBanner(),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ToggleButtons(
                            borderRadius: BorderRadius.circular(10.0),
                            selectedColor: Colors.white,
                            color: Colors.white.withOpacity(0.15),
                            fillColor: AppColors.greenColor,
                            onPressed: (int newIndex) {
                              setState(() {
                                _showMachines = newIndex == 0;
                              });
                            },
                            isSelected: [_showMachines, !_showMachines],
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.12),
                                child: const Text('Machines',
                                    style: HomeScreenTextStyle.products),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.12),
                                child: const Text('Products',
                                    style: HomeScreenTextStyle.products),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                            child: _showMachines
                                ? _buildMachinesList(
                                    context, vendingMachinesList)
                                : _buildProductsList(
                                    context, vendingMachinesList)),
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

  Widget _buildMachinesList(
      BuildContext context, List<VendingMachine> machines) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: ListView.builder(
        itemCount: machines.length,
        itemBuilder: (context, index) {
          final machine = machines[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MachineDetailsScreen(
                    vendingMachine: machine,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.white.withOpacity(0.15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            machine.name,
                            style: HomeScreenTextStyle.name,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        ...machine.machineTypes.map((type) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.greenColor.withOpacity(0.25),
                            ),
                            child: Text(
                              type.toString().split('.').last,
                              style: HomeScreenTextStyle.type,
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                    Text(
                      machine.location,
                      style: HomeScreenTextStyle.location,
                    ),
                    SizedBox(height: size.width * 0.02),
                    const Text(
                      'Products:',
                      style: HomeScreenTextStyle.products,
                    ),
                    SizedBox(height: size.width * 0.015),
                    Container(
                      height: size.height * 0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: machine.products.map((product) {
                          return Container(
                            margin: EdgeInsets.only(right: 12),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange.withOpacity(0.25),
                            ),
                            child: Center(
                              child: Text(
                                product.name,
                                style: HomeScreenTextStyle.restock,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductsList(
      BuildContext context, List<VendingMachine> vendingMachinesList) {
    final size = MediaQuery.of(context).size;
    List<Product> allProducts =
        vendingMachinesList.expand((machine) => machine.products).toList();

    return ListView.builder(
      itemCount: allProducts.length,
      itemBuilder: (context, index) {
        final product = allProducts[index];
        final machine = vendingMachinesList
            .firstWhere((machine) => machine.products.contains(product));
        final machineType =
            machine.machineTypes.first.toString().split('.').last;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MachineDetailsScreen(vendingMachine: machine),
              ),
            );
          },
          child: Card(
            color: Colors.white.withOpacity(0.15),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        product.name,
                        style: HomeScreenTextStyle.name,
                      ),
                      SizedBox(width: size.width * 0.03),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.greenColor.withOpacity(0.25),
                        ),
                        child: Text(
                          machineType,
                          style: HomeScreenTextStyle.type,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.width * 0.03),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.orange.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Text(
                        'Needs to be restocked  ${product.consumptionPeriod.toString().split('.').last}',
                        style: HomeScreenTextStyle.restock,
                      ),
                    ),
                  ),
                  SizedBox(height: size.width * 0.02),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.15),
                    ),
                    child: Center(
                      child: Text(
                        machine.name,
                        style: HomeScreenTextStyle.location,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
