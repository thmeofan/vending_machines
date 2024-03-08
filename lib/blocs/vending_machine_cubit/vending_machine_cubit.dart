import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/vending_machine.dart';
import '../../util/shared_pref_service.dart';

class VendingMachineCubit extends Cubit<VendingMachine?> {
  final SharedPreferencesService _sharedPreferencesService;

  VendingMachineCubit(this._sharedPreferencesService) : super(null) {
    _loadVendingMachine();
  }

  void _loadVendingMachine() async {
    final vendingMachine = await _sharedPreferencesService.getVendingMachine();
    emit(vendingMachine);
  }

  void updateBasicInfo(String name, String location) {
    final updatedVendingMachine = state?.copyWith(
          name: name,
          location: location,
        ) ??
        VendingMachine(
          name: name,
          location: location,
        );
    emit(updatedVendingMachine);
    _saveVendingMachine(updatedVendingMachine);
  }

  void updateMachineTypes(List<MachineType> machineTypes) {
    final updatedVendingMachine = state?.copyWith(
          machineTypes: machineTypes,
        ) ??
        VendingMachine(
          machineTypes: machineTypes,
        );
    emit(updatedVendingMachine);
    _saveVendingMachine(updatedVendingMachine);
  }

  void addProduct(Product product) {
    final updatedVendingMachine = state?.copyWith(
          products: [...?state?.products, product],
        ) ??
        VendingMachine(
          products: [product],
        );
    emit(updatedVendingMachine);
    _saveVendingMachine(updatedVendingMachine);
  }

  Future<void> _saveVendingMachine(VendingMachine vendingMachine) async {
    await _sharedPreferencesService.saveVendingMachine(vendingMachine);
  }
}
