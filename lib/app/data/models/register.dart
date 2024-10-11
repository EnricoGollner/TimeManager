import 'package:flutter/material.dart';

class Register {
  int id;
  String company;
  DateTime monthYear;
  TimeOfDay timeToPay;
  TimeOfDay payedTime;
  double salaryPerMonth;
  double? salaryPerDay; //(obtained dividing salary per month by working days count)
  int workingDaysCount;  // The app will obtain it
  TimeOfDay workingJourneyHours;  //Not counting breaks

  Register({
    required this.id,
    required this.company,
    required this.monthYear,
    required this.timeToPay,
    required this.payedTime,
    required this.salaryPerMonth,
    this.salaryPerDay,
    required this.workingDaysCount,
    required this.workingJourneyHours,
  });

  @override
  bool operator ==(covariant Register other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.company == company &&
      other.monthYear == monthYear &&
      other.timeToPay == timeToPay &&
      other.payedTime == payedTime &&
      other.salaryPerMonth == salaryPerMonth &&
      other.salaryPerDay == salaryPerDay &&
      other.workingDaysCount == workingDaysCount &&
      other.workingJourneyHours == workingJourneyHours;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      company.hashCode ^
      monthYear.hashCode ^
      timeToPay.hashCode ^
      payedTime.hashCode ^
      salaryPerMonth.hashCode ^
      salaryPerDay.hashCode ^
      workingDaysCount.hashCode ^
      workingJourneyHours.hashCode;
  }
}
