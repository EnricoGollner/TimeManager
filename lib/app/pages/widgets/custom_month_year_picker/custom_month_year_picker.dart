import 'package:flutter/material.dart';
import 'package:working_time_manager/app/pages/widgets/custom_month_year_picker/custom_dialog.dart';
import 'package:working_time_manager/app/pages/widgets/custom_month_year_picker/month_container.dart';
import 'package:working_time_manager/app/pages/widgets/custom_month_year_picker/month_model.dart';

class CustomMonthYearPicker {
  /// list of Months
  static final List<MonthModel> _monthModelList = [
    MonthModel(index: 1, name: 'Jan'),
    MonthModel(index: 2, name: 'Feb'),
    MonthModel(index: 3, name: 'Mar'),
    MonthModel(index: 4, name: 'Apr'),
    MonthModel(index: 5, name: 'May'),
    MonthModel(index: 6, name: 'Jun'),
    MonthModel(index: 7, name: 'Jul'),
    MonthModel(index: 8, name: 'Aug'),
    MonthModel(index: 9, name: 'Sep'),
    MonthModel(index: 10, name: 'Oct'),
    MonthModel(index: 11, name: 'Nov'),
    MonthModel(index: 12, name: 'Dec'),
  ];

  static Future<DateTime> showMonthYearPickerDialog({
    required BuildContext context,
    TextStyle? titleTextStyle,
    TextStyle? yearTextStyle,
    TextStyle? monthTextStyle,
    Color? backgroundColor,
    Color? selectionColor,
    Color? arrowColors,
    required Color confirmTextColor,
    bool? barrierDismissible,
    bool? disableFuture,
  }) async {
    final ThemeData theme = Theme.of(context);
    var primaryColor = selectionColor ?? theme.primaryColor;
    var bgColor = backgroundColor ?? theme.scaffoldBackgroundColor;
    // var textTheme = theme.textTheme;

    /// to get current year
    int selectedYear = DateTime.now().year;

    /// to get index corresponding to current month (1- Jan, 2- Feb,..)
    var selectedMonth = DateTime.now().month;

    Widget buildYearSelector({required void Function() onPressPrev, required void Function() onPressNext}) {
      return Row(
        children: [
          IconButton(
            onPressed: onPressPrev,
            icon: Icon(
              Icons.arrow_back_ios,
              size: 10,
              color: arrowColors ?? Colors.red,
            ),
          ),
          Text(
            selectedYear.toString(),
            style: yearTextStyle ??
                const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Rajdhani',
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (!(disableFuture == true && selectedYear == DateTime.now().year))
          IconButton(
            onPressed: onPressNext,
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 10,
              color: arrowColors ?? Colors.red,
            ),
            )
          else const SizedBox(width: 50),
        ],
      );
    }

    await showDialog<DateTime>(
      context: context,
      barrierDismissible: barrierDismissible ?? true,
      builder: (_) {
        return StatefulBuilder(builder: (context, setState) {
          return CustomDialog(
            child: Container(
              padding: const EdgeInsets.all(20),
              height: 340,
              width: 370,
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Month ',
                        style: titleTextStyle ??
                            const TextStyle(
                              fontFamily: 'Rajdhani',
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      
                      buildYearSelector(
                        onPressPrev: () => setState(() => selectedYear--),
                        onPressNext: () => setState(() => selectedYear++),
                      ),
                    ],
                  ),
                  Flexible(
                    child: GridView.builder(
                      itemCount: _monthModelList.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 1.4,
                      ),
                      itemBuilder: (_, index) {
                        final MonthModel monthModel = _monthModelList[index];
                        return InkWell(
                          onTap: () => setState(() => selectedMonth = index + 1),
                          onHover: (val) {},
                          child: MonthContainer(
                            textStyle: monthTextStyle?.copyWith(
                              color: index + 1 == selectedMonth ? monthTextStyle.color : monthTextStyle.color?.withOpacity(0.6),
                            ),
                            month: monthModel.name,
                            isSelected: index + 1 == selectedMonth,
                            fillColor: index + 1 == selectedMonth
                                ? primaryColor
                                : bgColor,
                            borderColor: index + 1 == selectedMonth
                                ? primaryColor
                                : bgColor,
                            textColor: index + 1 != selectedMonth
                                ? primaryColor
                                : bgColor,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          String selectedMonthString = selectedMonth < 10
                              ? "0$selectedMonth"
                              : "$selectedMonth";
                          var selectedDate = DateTime.parse('$selectedYear-$selectedMonthString-01');
                          Navigator.pop(context, selectedDate);
                        },
                        child: Container(
                          height: 30,
                          width: 70,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            border: Border.all(
                              color: primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              'OK',
                              style: TextStyle(color: confirmTextColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      },
    );
    String selectedMonthString = selectedMonth < 10 ? "0$selectedMonth" : "$selectedMonth";

    return DateTime.parse('$selectedYear-$selectedMonthString-01');
  }
}
