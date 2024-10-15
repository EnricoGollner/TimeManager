import 'package:flutter/material.dart';

class MonthContainer extends StatelessWidget {
  const MonthContainer({
    super.key,
    required this.isSelected,
    required this.month,
    required this.fillColor,
    required this.borderColor,
    required this.textColor,
    required this.textStyle,
  });

  final bool isSelected;
  final String month;
  final Color fillColor;
  final Color borderColor;
  final Color textColor;
  final TextStyle? textStyle;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: fillColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          month,
          style: textStyle ??
              TextStyle(
                fontSize: 18,
                color: isSelected ? textColor : textColor.withOpacity(0.6),
              ),
        ),
      ),
    );
  }
}
