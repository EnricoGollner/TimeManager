import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:working_time_manager/core/app_responsivity.dart';

TextStyle appBarTitleStyle(BuildContext context) => GoogleFonts.dmSerifText(
    fontSize: 20.s,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.inversePrimary,
  );

TextStyle valueLabel(BuildContext context) => GoogleFonts.dmSerifText(
    fontSize: 15.s2,
    color: Theme.of(context).colorScheme.inversePrimary,
  );

TextStyle textFieldStyle(BuildContext context) => GoogleFonts.dmSans(
    fontSize: 14.s2,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.inversePrimary,
    decoration: TextDecoration.none,
  );
