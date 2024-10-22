import 'package:flutter/material.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/data/repositories/register_repository.dart';

class RegisterController extends ChangeNotifier {
  final RegisterRepository _repository = RegisterRepository();
  // List of registers
  final List<Register> _registers = [];
  List<Register> get registers => _registers;

  Register? _selectedRegister;
  Register? get selectedRegister => _selectedRegister;

  void selectRegister(Register register) {
    _selectedRegister = register;
    notifyListeners();
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> createRegister({required Register newRegister}) async {
    final int? id = await _repository.createRegister(newRegister);
    id != null
        ? _registers.add(newRegister.copyWith(id: id))
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

  Future<void> updatePayedTimeInRegister({required int id, required Duration paidDuration}) async {
    final Register register = registers.firstWhere((register) => register.id == id);

    final Register updatedRegister = register.copyWith(
      paidRegisteredTime: register.paidRegisteredTime + paidDuration,
    );

    final bool result = await _repository.updateRegister(
      id,
      updatedRegister,
    );

    if (result) {
      await getRegisters();
      selectRegister(updatedRegister);
    } else {
      _errorMessage = 'Error updating the register';
    }

    notifyListeners();
  }

  Future<void> deleteRegister(int id) async {
    final bool result = await _repository.deleteRegister(id);
    
    if (result) {
      await getRegisters();
    } else {
      _errorMessage = 'Error deleting the register';
    }
  }
}