import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:working_time_manager/app/pages/widgets/indicator_widget.dart';
import 'package:working_time_manager/core/app_responsivity.dart';

class PizzaChart extends StatefulWidget {
  final double workedValue;
  final double notWorkedValue;

  const PizzaChart({
    super.key,
    required this.workedValue,
    required this.notWorkedValue,
  });

  @override
  State<PizzaChart> createState() => PizzaChatState();
}

class PizzaChatState extends State<PizzaChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Row(
        children: [
          const SizedBox(height: 18),
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: _showingSections(),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Indicator(
                color: Colors.green,
                text: 'Worked',
                isSquare: true,
              ),
              SizedBox(height: 4),
              Indicator(
                color: Colors.red,
                text: 'Not Worked',
                isSquare: true,
              ),
              SizedBox(height: 18),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25.s : 16.s;
      final double  radius = isTouched ? 60.s : 50.s;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: widget.notWorkedValue,
            title: '${widget.notWorkedValue.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.green,
            value: widget.workedValue,
            title: '${widget.workedValue.toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}