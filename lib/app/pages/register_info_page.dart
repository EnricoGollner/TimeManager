

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/controller/working_time_controller.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/pages/widgets/custom_value.dart';
import 'package:working_time_manager/app/pages/widgets/pizza_chart.dart';
import 'package:working_time_manager/app/shared/util/formatter.dart';
import 'package:working_time_manager/core/app_responsivity.dart';
import 'package:working_time_manager/core/theme/fonts.dart';

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({super.key});

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  late Register _register;

  @override
  void initState() {
    _register = context.read<WorkingTimeController>().selectedRegister!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${_register.company} - ${Formatter.monthYear(_register.monthYear)}', style: appBarTitleStyle(context)),
      ),
      body: Column(
        children: [
          PizzaChart(
            workedValue: _register.workedPercentage,
            notWorkedValue: _register.notWorkedPercentage,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.s),
            child: Column(
              children: [
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 1,
                ),
                CustomValue(
                  label: 'Monthly salary',
                  value: Formatter.formatNumber(_register.salaryPerMonth),
                ),
                CustomValue(
                  label: 'Daily salary',
                  value: Formatter.formatNumber(_register.dailySalary),
                ),
                CustomValue(
                  label: 'Hourly salary',
                  value: Formatter.formatNumber(_hourlySalary),
                ),
                CustomValue(
                  label: 'Paied Time',
                  value: Formatter.durationToString(_register.payedTime),
                ),
                CustomValue(
                  label: 'Time to pay',
                  value: Formatter.durationToString(_register.timeToPay),
                ),
                CustomValue(
                  label: 'Amount to pay',
                  value: Formatter.formatNumber(_amountToPay),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  num get _hourlySalary {
    return _register.dailySalary / (_register.workingJourneyHours.inMinutes / 60);
  }

  ///Returns the amount loosing if not paying the hours the user owes
  double get _amountToPay {
    double timeToPayInHours = _register.timeToPay.inMinutes / 60;
    return _hourlySalary * timeToPayInHours;
  }
}