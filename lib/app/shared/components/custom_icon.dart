import 'package:flutter/material.dart';
import 'package:working_time_manager/core/app_responsivity.dart';

class CustomIcon extends StatelessWidget {
  final Color? color;
  final IconData? iconData;

  const CustomIcon({
    super.key,
    this.color,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      size: 21.s2,
      color: color,
      iconData,
    );
  }
}
