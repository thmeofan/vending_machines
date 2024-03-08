import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/vending_machine.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesService {
  static const String _vendingMachineKey = 'vending_machine';

  Future<void> saveVendingMachine(VendingMachine vendingMachine) async {
    final prefs = await SharedPreferences.getInstance();
    final vendingMachineJson = jsonEncode(vendingMachine.toJson());
    await prefs.setString(_vendingMachineKey, vendingMachineJson);
  }

  Future<VendingMachine?> getVendingMachine() async {
    final prefs = await SharedPreferences.getInstance();
    final vendingMachineJson = prefs.getString(_vendingMachineKey);
    if (vendingMachineJson != null) {
      final vendingMachineMap = jsonDecode(vendingMachineJson);
      return VendingMachine.fromJson(vendingMachineMap);
    }
    return null;
  }
}
