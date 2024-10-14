// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:working_time_manager/app/data/models/register.dart';



class WorkingTimeController extends ChangeNotifier {
//   static late Isar isar;

//   // Initializing Database()
//   static Future<void> initialize() async {
//     final Directory dir = await getApplicationDocumentsDirectory();
//     isar = await Isar.open([WorkingTimeRegisterSchema], directory: dir.path);
//   }

  // List of registers
  final List<Register> registers = [];

  Register? _selectedRegister;
  Register? get selectedRegister => _selectedRegister;

  void selectRegister(Register register) {
    _selectedRegister = register;
    notifyListeners();
  }

  // Create
  Future<void> createRegister({required Register newRegister}) async {
    registers.add(newRegister);
    notifyListeners();
    // await isar.writeTxn(() => isar.workingTimeRegisters.put(time));
    // await getTimeRegisters();
  }

  // Read
  Future<void> getTimeRegisters() async {
    // List<WorkingTimeRegister> timeRegisters = await isar.workingTimeRegisters.where().findAll();
    
    // List<Register> timeRegisters = [];

    registers.clear();
    registers.addAll(registers);
    notifyListeners();
  }

//   // Update
//   Future<void> updateTimeRegister({required int id, required String edittedText}) async {
//     final WorkingTimeRegister? timeRegister = await isar.workingTimeRegisters.get(id);

//     if (timeRegister != null) {
//       // timeRegister.text = edittedText;
//       await isar.writeTxn(() => isar.workingTimeRegisters.put(timeRegister));
//       await getTimeRegisters();
//     }
//   }

  // Delete
  Future<void> deleteTimeRegister(int id) async {
    // await isar.writeTxn(() => isar.workingTimeRegisters.delete(id));
    registers.removeWhere((element) => element.id == id);
    await getTimeRegisters();
  }
}