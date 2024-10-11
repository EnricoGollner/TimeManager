

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/controller/working_time_controller.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/pages/widgets/pizza_chart.dart';
import 'package:working_time_manager/app/shared/util/formatter.dart';
import 'package:working_time_manager/core/theme/fonts.dart';

class RegisterInfoPage extends StatefulWidget {
  const RegisterInfoPage({super.key});

  @override
  State<RegisterInfoPage> createState() => _RegisterInfoPageState();
}

class _RegisterInfoPageState extends State<RegisterInfoPage> {
  late Register register;

  @override
  void initState() {
    register = context.read<WorkingTimeController>().selectedRegister!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${register.company} - ${Formatter.monthYear(register.monthYear)}', style: appBarTitleStyle(context)),
      ),
      body: Column(
        children: [
          const PizzaChart(
            workedValue: 10,
            notWorkedValue: 90,
          ),
          Divider(
            color: Theme.of(context).colorScheme.inversePrimary,
            thickness: 1,
          ),
        ],
      ),
    );
  }

}