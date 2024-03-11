import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/vending_machine.dart';
import '../../util/shared_pref_service.dart';

class VendingMachineCubit extends Cubit<List<VendingMachine>> {
  final SharedPreferencesService _sharedPreferencesService;

  VendingMachineCubit(this._sharedPreferencesService) : super([]) {
    _loadVendingMachines();
  }

  void _loadVendingMachines() async {
    final vendingMachines =
        await _sharedPreferencesService.getVendingMachines();
    emit(vendingMachines);
  }

  void addVendingMachine(VendingMachine vendingMachine) async {
    final List<VendingMachine> updatedList = List.from(state)
      ..add(vendingMachine);
    emit(updatedList);
    await _sharedPreferencesService.saveVendingMachines(updatedList);
  }

  void updateVendingMachinesList(List<VendingMachine> updatedList) async {
    emit(updatedList);
    await _sharedPreferencesService.saveVendingMachines(updatedList);
  }

}
