import 'dart:io';

import 'package:flutter/material.dart';

class Validator {
  static String? isRequired(String? text) {
    if(text == null || text.isEmpty) {
      return 'Text required to register!';
    }

    return null;
  }

  static void handleDecimal(TextEditingController controller, {int decimalRange = 2, bool isCurrency = false}) {
    String signal = Platform.localeName == 'pt_BR' ? ',' : '.';
    String controllerText = controller.text.isEmpty ? '0' : controller.text;
    String value = controllerText;

    if(value.isNotEmpty){
      if (!value.contains(signal)) {
        value += signal;
      }

      List<String> parts = value.split(signal);
      String decimalPart = parts.length > 1 ? parts[1] : '';
      int currentDecimalRange = decimalPart.length;

      if (currentDecimalRange <= decimalRange) {
        int zerosToAdd = decimalRange - currentDecimalRange;
        String zeros = '0' * zerosToAdd;

        controller.value = controller.value.copyWith(
          text: '$value$zeros',
          selection: TextSelection.collapsed(offset: '$value$zeros'.length),
        );
      }
    }
  }
}