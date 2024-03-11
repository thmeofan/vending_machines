import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/vending_machine.dart';

class SharedPreferencesService {
  static const String _vendingMachinesKey = 'vending_machines';

  Future<void> saveVendingMachines(List<VendingMachine> vendingMachines) async {
    final prefs = await SharedPreferences.getInstance();
    final vendingMachinesJson =
        jsonEncode(vendingMachines.map((vm) => vm.toJson()).toList());
    await prefs.setString(_vendingMachinesKey, vendingMachinesJson);
  }

  Future<List<VendingMachine>> getVendingMachines() async {
    final prefs = await SharedPreferences.getInstance();
    final vendingMachinesJson = prefs.getString(_vendingMachinesKey);
    if (vendingMachinesJson != null) {
      final List<dynamic> vendingMachinesList = jsonDecode(vendingMachinesJson);
      return vendingMachinesList
          .map((json) => VendingMachine.fromJson(json))
          .toList();
    }
    return [];
  }
}
