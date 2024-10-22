import 'package:hive/hive.dart';

part 'register.g.dart';

@HiveType(typeId: 0)
class Register extends HiveObject {
  @HiveField(0)
  String company;
  @HiveField(1)
  DateTime monthYear;
  @HiveField(2)
  Duration timeToPay;
  @HiveField(3)
  Duration paidTime;
  @HiveField(4)
  double salaryPerMonth;
  @HiveField(5)
  double dailySalary; //(obtained dividing salary per month by working days count)
  @HiveField(6)
  int workingDaysCount;  // The app will obtain it, looping and counting every business day 
  @HiveField(7)
  Duration workingJourneyHours;  //Not counting breaks

  Register({
    required this.company,
    required this.monthYear,
    required this.timeToPay,
    required this.paidTime,
    required this.salaryPerMonth,
    this.dailySalary = 0,
    required this.workingDaysCount,
    required this.workingJourneyHours,
  });

  @override
  bool operator ==(covariant Register other) {
    if (identical(this, other)) return true;
  
    return 
      other.company == company &&
      other.monthYear == monthYear &&
      other.timeToPay == timeToPay &&
      other.paidTime == paidTime &&
      other.salaryPerMonth == salaryPerMonth &&
      other.dailySalary == dailySalary &&
      other.workingDaysCount == workingDaysCount &&
      other.workingJourneyHours == workingJourneyHours;
  }

  @override
  int get hashCode {
    return company.hashCode ^
      monthYear.hashCode ^
      timeToPay.hashCode ^
      paidTime.hashCode ^
      salaryPerMonth.hashCode ^
      dailySalary.hashCode ^
      workingDaysCount.hashCode ^
      workingJourneyHours.hashCode;
  }

  double get notWorkedPercentage {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double paidTimeInHours = paidTime.inMinutes / 60;

    double notWorkedTimeInHours = timeToPayInHours - paidTimeInHours;
    double percentage = (notWorkedTimeInHours > 0 ? notWorkedTimeInHours : 0) * 100 / timeToPayInHours;

    return percentage.isNaN ? 0 : percentage;
  }

  double get workedPercentage {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double paidTimeInHours = paidTime.inMinutes / 60;

    final double workedPercentage = (paidTimeInHours <= timeToPayInHours) 
      ? (paidTimeInHours / timeToPayInHours) * 100 
      : 100;

    return workedPercentage.isNaN ? 0 : workedPercentage;
  }

  Duration get extras {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double paidTimeInHours = paidTime.inMinutes / 60;

    double extrasInHours = paidTimeInHours - timeToPayInHours;
    return Duration(hours: extrasInHours.toInt());
  }

  Register copyWith({
    String? company,
    DateTime? monthYear,
    Duration? timeToPay,
    Duration? paidTime,
    double? salaryPerMonth,
    double? dailySalary,
    int? workingDaysCount,
    Duration? workingJourneyHours,
  }) {
    return Register(
      company: company ?? this.company,
      monthYear: monthYear ?? this.monthYear,
      timeToPay: timeToPay ?? this.timeToPay,
      paidTime: paidTime ?? this.paidTime,
      salaryPerMonth: salaryPerMonth ?? this.salaryPerMonth,
      dailySalary: dailySalary ?? this.dailySalary,
      workingDaysCount: workingDaysCount ?? this.workingDaysCount,
      workingJourneyHours: workingJourneyHours ?? this.workingJourneyHours,
    );
  }
}
