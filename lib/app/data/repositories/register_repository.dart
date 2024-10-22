import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:working_time_manager/app/data/models/register.dart';

class RegisterRepository {
  final Box<Register> _registersBox;

  RegisterRepository() : _registersBox = Hive.box<Register>('registers');

  Future<List<Register>?> getRegisters() async {
    try {
      final List<Register> registers = _registersBox.values.toList().map((register) => register.copyWith(id: register.key)).toList();
      return registers;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<int?> createRegister(Register register) async {
    try {
      return await _registersBox.add(register);
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }

  Future<bool> updateRegister(int id, Register register) async {
    try {
      await _registersBox.put(id, register);
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> deleteRegister(int id) async {
    try {
      await _registersBox.delete(id);
      return true;
    } catch (_) {
      return false;
    }
  }
}