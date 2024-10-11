import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/controller/working_time_controller.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/shared/components/custom_text_field.dart';
import 'package:working_time_manager/app/shared/util/formatter.dart';
import 'package:working_time_manager/app/shared/util/validator.dart';
import 'package:working_time_manager/core/app_responsivity.dart';
import 'package:working_time_manager/core/theme/fonts.dart';

class TimeRegister extends StatefulWidget {
  const TimeRegister({super.key});

  @override
  TimeRegisterState createState() => TimeRegisterState();
}

class TimeRegisterState extends State<TimeRegister> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _ctrlCompanyName = TextEditingController();

  late DateTime _monthYear;
  late final TextEditingController _ctrlMonthYear;

  TimeOfDay _timeToPay = const TimeOfDay(hour: 0, minute: 0);
  TimeOfDay _payedTime = const TimeOfDay(hour: 0, minute: 0);
  late final TextEditingController _ctrlTimeToPay;
  late final TextEditingController _ctrlPayedTime;

  final TextEditingController _ctrlSalaryPerMonth = TextEditingController();

  TimeOfDay _hoursJourney = const TimeOfDay(hour: 0, minute: 0);
  final TextEditingController _ctrlHoursJourney = TextEditingController();

  @override
  void initState() {
    _monthYear = DateTime.now();
    _ctrlMonthYear = TextEditingController(text: Formatter.monthYear(_monthYear));

    _ctrlTimeToPay = TextEditingController(text: Formatter.time(_timeToPay));
    _ctrlPayedTime = TextEditingController(text: Formatter.time(_payedTime));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 350.s5,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('New Dashboard', style: appBarTitleStyle(context)),
                          IconButton(
                            tooltip: 'Close',
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        validatorFunction: Validator.isRequired,
                        
                        label: "Company's name:",
                        controller: _ctrlCompanyName,
                        hintText: "Inform company's name here...",
                      ),
                      const SizedBox(height: 15),
                      CustomTextField.dateTimeField(
                        validatorFunction: Validator.isRequired,
                        onTap: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            helpText: 'Selecione a data do prazo',
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            confirmText: 'Selecionar',
                          ).then(
                            (prazoSelecionado) async {},
                          );
                        },
                        controller: _ctrlMonthYear,
                        label: "Dashboard's Month & Year:",
                        hintText: 'Month & Year',
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Flexible(
                            child: CustomTextField.dateTimeField(
                              validatorFunction: Validator.isRequired,
                              controller: _ctrlTimeToPay,
                              label: "Time to pay:",
                              onTap: () async {
                                _timeToPay = await _showTimePicker(initialTime: _timeToPay) ?? _timeToPay;
                                _ctrlTimeToPay.text = Formatter.time(_timeToPay);
                              },
                              hintText: 'Month & Year',
                            ),
                          ),
                          const SizedBox(width: 15),
                          Flexible(
                            child: CustomTextField.dateTimeField(
                              validatorFunction: Validator.isRequired,
                              controller: _ctrlPayedTime,
                              label: "Payed time:",
                              onTap: () async {
                                _payedTime = await _showTimePicker(initialTime: _payedTime) ?? _payedTime;
                                _ctrlPayedTime.text = Formatter.time(_payedTime);
                              },
                              hintText: 'Month & Year',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      CustomTextField.currency(
                        validatorFunction: Validator.isRequired,
                        controller: _ctrlSalaryPerMonth,
                        label: 'Salary per month:',
                        hintText: Formatter.formatNumber(0.0, 2),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField.dateTimeField(
                        validatorFunction: Validator.isRequired,
                        controller: _ctrlHoursJourney,
                        label: "Working journey hours",
                        onTap: () async {
                          _hoursJourney = await _showTimePicker(initialTime: _hoursJourney) ?? _hoursJourney;
                          _ctrlHoursJourney.text = Formatter.time(_hoursJourney);
                        },
                        hintText: 'Month & Year',
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: _createRegister,
                        child: Text(
                          'Create',
                          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  int get getWorkingDaysCount {
    DateTime lastDayOfMonth = DateTime(_monthYear.year, _monthYear.month + 1, 0);
    
    int workingDaysCount = 0;
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      DateTime currentDay = DateTime(_monthYear.year, _monthYear.month, day);
      if (currentDay.weekday != DateTime.saturday && currentDay.weekday != DateTime.sunday) {
        workingDaysCount++;
      }
    }
    return workingDaysCount;
  }

  double getSalaryPerDay(int workingDaysCount) {
    return Formatter.textToNum(text: _ctrlSalaryPerMonth.text) / workingDaysCount;
  }

  Future<void> _createRegister() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final int workingDaysCount = getWorkingDaysCount;

      final Register newRegister = Register(
        id: context.read<WorkingTimeController>().registers.length,
        company: _ctrlCompanyName.text,
        monthYear: _monthYear,
        timeToPay: _timeToPay,
        payedTime: _payedTime,
        salaryPerMonth: Formatter.textToNum(text: _ctrlSalaryPerMonth.text).toDouble(),
        salaryPerDay: getSalaryPerDay(workingDaysCount),
        workingDaysCount: workingDaysCount,
        workingJourneyHours: _hoursJourney,
      );

      await context.read<WorkingTimeController>().createRegister(newRegister: newRegister);
      if (mounted) Navigator.pop(context);
    }
  }

  Future<TimeOfDay?> _showTimePicker({required TimeOfDay initialTime}) async {
    return await showTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
        initialTime: initialTime,
      );
  }
}