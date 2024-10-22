// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterAdapter extends TypeAdapter<Register> {
  @override
  final int typeId = 0;

  @override
  Register read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Register(
      company: fields[0] as String,
      monthYear: fields[1] as DateTime,
      timeToPay: fields[2] as Duration,
      paidRegisteredTime: fields[3] as Duration,
      salaryPerMonth: fields[4] as double,
      dailySalary: fields[5] as double,
      workingDaysCount: fields[6] as int,
      workingJourneyHours: fields[7] as Duration,
    );
  }

  @override
  void write(BinaryWriter writer, Register obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.company)
      ..writeByte(1)
      ..write(obj.monthYear)
      ..writeByte(2)
      ..write(obj.timeToPay)
      ..writeByte(3)
      ..write(obj.paidRegisteredTime)
      ..writeByte(4)
      ..write(obj.salaryPerMonth)
      ..writeByte(5)
      ..write(obj.dailySalary)
      ..writeByte(6)
      ..write(obj.workingDaysCount)
      ..writeByte(7)
      ..write(obj.workingJourneyHours);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
