import 'package:hive/hive.dart';

part 'register.g.dart';

@HiveType(typeId: 0)
class Register extends HiveObject {
  int? id;
  @HiveField(0)
  String company;
  @HiveField(1)
  DateTime monthYear;
  @HiveField(2)
  Duration timeToPay;
  @HiveField(3)
  Duration paidRegisteredTime;
  @HiveField(4)
  double salaryPerMonth;
  @HiveField(5)
  double dailySalary; //(obtained dividing salary per month by working days count)
  @HiveField(6)
  int workingDaysCount;  // The app will obtain it, looping and counting every business day 
  @HiveField(7)
  Duration workingJourneyHours;  //Not counting breaks

  Register({
    this.id,
    required this.company,
    required this.monthYear,
    required this.timeToPay,
    required this.paidRegisteredTime,
    required this.salaryPerMonth,
    this.dailySalary = 0,
    required this.workingDaysCount,
    required this.workingJourneyHours,
  });

  @override
  bool operator ==(covariant Register other) {
    if (identical(this, other)) return true;
  
    return other.id == id &&
      other.company == company &&
      other.monthYear == monthYear &&
      other.timeToPay == timeToPay &&
      other.paidRegisteredTime == paidRegisteredTime &&
      other.salaryPerMonth == salaryPerMonth &&
      other.dailySalary == dailySalary &&
      other.workingDaysCount == workingDaysCount &&
      other.workingJourneyHours == workingJourneyHours;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      company.hashCode ^
      monthYear.hashCode ^
      timeToPay.hashCode ^
      paidRegisteredTime.hashCode ^
      salaryPerMonth.hashCode ^
      dailySalary.hashCode ^
      workingDaysCount.hashCode ^
      workingJourneyHours.hashCode;
  }

  Register copyWith({
    int? id,
    String? company,
    DateTime? monthYear,
    Duration? timeToPay,
    Duration? paidRegisteredTime,
    double? salaryPerMonth,
    double? dailySalary,
    int? workingDaysCount,
    Duration? workingJourneyHours,
  }) {
    return Register(
      id: id ?? this.id,
      company: company ?? this.company,
      monthYear: monthYear ?? this.monthYear,
      timeToPay: timeToPay ?? this.timeToPay,
      paidRegisteredTime: paidRegisteredTime ?? this.paidRegisteredTime,
      salaryPerMonth: salaryPerMonth ?? this.salaryPerMonth,
      dailySalary: dailySalary ?? this.dailySalary,
      workingDaysCount: workingDaysCount ?? this.workingDaysCount,
      workingJourneyHours: workingJourneyHours ?? this.workingJourneyHours,
    );
  }

  //Getters
  double get notWorkedPercentage {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double paidTimeInHours = paidRegisteredTime.inMinutes / 60;

    double notWorkedTimeInHours = timeToPayInHours - paidTimeInHours;
    double percentage = (notWorkedTimeInHours > 0 ? notWorkedTimeInHours : 0) * 100 / timeToPayInHours;

    return percentage.isNaN ? 0 : percentage;
  }

  double get workedPercentage {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double paidTimeInHours = paidRegisteredTime.inMinutes / 60;

    final double workedPercentage = (paidTimeInHours <= timeToPayInHours) 
      ? (paidTimeInHours / timeToPayInHours) * 100 
      : 100;

    return workedPercentage.isNaN ? 0 : workedPercentage;
  }

  Duration get paidTime {
    return extraTime <= paidRegisteredTime ? paidRegisteredTime - extraTime : Duration.zero;
  }

  Duration get extraTime {
    int timeToPayInMinutes = timeToPay.inMinutes;
    int paidTimeInMinutes = paidRegisteredTime.inMinutes;

    int extrasInMinutes = paidTimeInMinutes - timeToPayInMinutes;
    return extrasInMinutes > 0 ? Duration(minutes: extrasInMinutes) : Duration.zero;
  }

  num get extraPayment {
    return hourlySalary * (extraTime.inMinutes / 60);
  }

  num get hourlySalary {
    if (workingJourneyHours.inMinutes == 0) return 0;
    final double result = dailySalary / (workingJourneyHours.inMinutes / 60);
    return result.isNaN || result.isInfinite ? 0 : result;
  }

  double get amountToPay {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double paidTimeInHours = paidTime.inMinutes / 60;

    return hourlySalary * (timeToPayInHours - paidTimeInHours);
  }
}
