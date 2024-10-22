

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/controller/register_controller.dart';
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
  late WorkingTimeController _controller;
  late Register _register;

  @override
  void initState() {
    _controller = context.read<WorkingTimeController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _register = context.watch<WorkingTimeController>().selectedRegister!;
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${_register.company} - ${Formatter.monthYear(_register.monthYear)}', style: appBarTitleStyle(context)),
        actions: [
          IconButton(
            tooltip: 'Delete Dashboard',
            onPressed: () {
              _controller.deleteRegister(_register.key);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
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
                  label: 'paid Time',
                  value: Formatter.durationToString(_register.paidTime),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()  async {
          final TimeOfDay? paidTime = await showTimePicker(
            context: context,
            initialTime: const TimeOfDay(hour: 1, minute: 0),
            builder: (BuildContext context, Widget? child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );
          if (paidTime != null) {
            _controller.updatePayedTimeInRegister(key: _register.key, duration: Duration(hours: paidTime.hour, minutes: paidTime.minute));
          }
        },
        label: Text(
          'Add paid hour',
          style: fabStyle(context),
        ),
        icon: Icon(
          Icons.more_time,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
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