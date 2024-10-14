class Register {
  int id;
  String company;
  DateTime monthYear;
  Duration timeToPay;
  Duration payedTime;
  double salaryPerMonth;
  double dailySalary; //(obtained dividing salary per month by working days count)
  int workingDaysCount;  // The app will obtain it, looping and counting every business day 
  Duration workingJourneyHours;  //Not counting breaks

  Register({
    required this.id,
    required this.company,
    required this.monthYear,
    required this.timeToPay,
    required this.payedTime,
    required this.salaryPerMonth,
    this.dailySalary = 0,
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
      payedTime.hashCode ^
      salaryPerMonth.hashCode ^
      dailySalary.hashCode ^
      workingDaysCount.hashCode ^
      workingJourneyHours.hashCode;
  }

  double get notWorkedPercentage {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double payedTimeInHours = payedTime.inMinutes / 60;

    double notWorkedTimeInHours = timeToPayInHours - payedTimeInHours;

    return (notWorkedTimeInHours > 0 ? notWorkedTimeInHours : 0) * 100 / timeToPayInHours;
  }

  double get workedPercentage {
    double timeToPayInHours = timeToPay.inMinutes / 60;
    double payedTimeInHours = payedTime.inMinutes / 60;

    double workedTimeInHours = payedTimeInHours;

    return (workedTimeInHours <= timeToPayInHours) 
      ? (workedTimeInHours / timeToPayInHours) * 100 
      : 100;
  }
}
