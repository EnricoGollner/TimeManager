import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:working_time_manager/core/app_responsivity.dart';

TextStyle appBarTitleStyle(BuildContext context) => GoogleFonts.dmSerifText(
      fontSize: 20.s,
      color: Theme.of(context).colorScheme.inversePrimary,
    );
TextStyle textFieldStyle(BuildContext context) => GoogleFonts.dmSans(
    fontSize: 14.2.s2,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.inversePrimary,
    decoration: TextDecoration.none);
