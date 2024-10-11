import 'package:flutter/material.dart';
import 'package:working_time_manager/core/theme/colors.dart';

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: colorBackgroundLight,
    primary: colorPrimaryLight,
    secondary: colorSecondaryLight,
    inversePrimary: colorInversePrimaryLight
  ),
  datePickerTheme: DatePickerThemeData(
    cancelButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),
    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(colorInversePrimaryLight)),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: colorInversePrimaryLight,
  ),
  timePickerTheme: TimePickerThemeData(
    dialTextColor: colorInversePrimaryLight,
    hourMinuteTextColor: colorInversePrimaryLight,
    dialTextStyle: TextStyle(color: colorInversePrimaryLight),
    cancelButtonStyle:  const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),
    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(colorInversePrimaryLight)),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: colorBackgroundDark,
    primary: colorPrimaryDark,
    secondary: colorSecondaryDark,
    inversePrimary: colorInversePrimaryDark,
  ),
  datePickerTheme: DatePickerThemeData(
    dayStyle: TextStyle(color: colorInversePrimaryDark),
    todayForegroundColor: WidgetStatePropertyAll(colorInversePrimaryDark),
    dayForegroundColor: WidgetStatePropertyAll(colorInversePrimaryDark),
    cancelButtonStyle: const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),
    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(colorInversePrimaryDark)),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: colorInversePrimaryDark,
  ),
  timePickerTheme: TimePickerThemeData(
    dialTextColor: colorInversePrimaryDark,
    hourMinuteTextColor: colorInversePrimaryDark,
    dialTextStyle: TextStyle(color: colorInversePrimaryDark),
    cancelButtonStyle:  const ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.red)),
    confirmButtonStyle: ButtonStyle(foregroundColor: WidgetStatePropertyAll(colorInversePrimaryDark)),
  ),
);
