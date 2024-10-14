import 'package:flutter/material.dart';
import 'package:working_time_manager/core/theme/fonts.dart';

///Widget que controi uma columa de string com label e valor
class CustomValue extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const CustomValue({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            style: labelStyle ?? valueLabel(context),
          ),
        ),
        Text(
          value,
          style: valueStyle ?? textFieldStyle(context),
        ),
      ],
    );
  }
}
