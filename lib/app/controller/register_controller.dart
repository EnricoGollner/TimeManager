import 'package:flutter/material.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/data/repositories/register_repository.dart';

class WorkingTimeController extends ChangeNotifier {
  final RegisterRepository _repository = RegisterRepository();
  // List of registers
  final List<Register> _registers = [];
  List<Register> get registers => _registers;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Register? _selectedRegister;
  Register? get selectedRegister => _selectedRegister;

  void selectRegister(Register register) {
    _selectedRegister = register;
    notifyListeners();
  }

  Future<void> createRegister({required Register newRegister}) async {
    final int? id = await _repository.createRegister(newRegister);
    id != null
        ? _registers.add(newRegister)
        : _errorMessage = 'Error while creating a new register';

    notifyListeners();
  }

  Future<void> getRegisters() async {
    List<Register>? dbRegisters = await _repository.getRegisters();
    
    if (dbRegisters != null) {
      _registers.clear();
      _registers.addAll(dbRegisters);
    } else {
      _errorMessage = 'Error while searching for the registers.';
    }
    
    notifyListeners();
  }

  Future<void> updatePayedTimeInRegister({required int key, required Duration duration}) async {
    final Register register = registers.firstWhere((register) => register.key == key);
    final bool result = await _repository.updateRegister(
      key,
      register.copyWith(paidTime: register.paidTime + duration),
    );
    
    if (!result) {
      await getRegisters();
    } else {
      _errorMessage = 'Error updating the register';
    }

    notifyListeners();
  }

  Future<void> updateRegister({required int key, required Register register}) async {
    final bool result = await _repository.updateRegister(key, register);
    
    if (!result) {
      await getRegisters();
    } else {
      _errorMessage = 'Error updating the register';
    }

    notifyListeners();
  }

  Future<void> deleteRegister(int key) async {
    final bool result = await _repository.deleteRegister(key);
    
    if (result) {
      await getRegisters();
    } else {
      _errorMessage = 'Error deleting the register';
    }
  }
}