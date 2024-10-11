import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class DecimalTextInputFormatter extends TextInputFormatter {
  final int decimalRange;
  DecimalTextInputFormatter({this.decimalRange = 1});

  ///Retorna o sinal decimal, de acordo com a localização do dispositivo
  static FilteringTextInputFormatter get regexSignal => Platform.localeName == 'pt_BR'
    ? FilteringTextInputFormatter.allow(RegExp("[0-9,]"))
    : FilteringTextInputFormatter.allow(RegExp("[0-9.]"));
  static String get signal => Platform.localeName == 'pt_BR' ? ',' : '.';

  ///Nega sinais decimais no campo, usado quando for desejado o uso de numeros inteiros
  static TextInputFormatter notAllowSignal() => FilteringTextInputFormatter.digitsOnly;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;
    String signal = Platform.localeName == 'pt_BR' ? ',' : '.';

    String value = newValue.text;

    final String zerosParaApagar = '0$signal${'0' * decimalRange}';
    if (oldValue.text == zerosParaApagar) {
      truncated = value.replaceFirst(zerosParaApagar, '');
      value = truncated;
      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    }

    if(!value.contains(signal) && value.length > 9) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value.contains(signal) && value.split(signal)[0].length > 9) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    if (value.contains(signal) && value.substring(value.indexOf(signal) + 1).length > decimalRange) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    } else if (value == signal) {
      truncated = "0$signal";

      newSelection = newValue.selection.copyWith(
        baseOffset: math.min(truncated.length, truncated.length + 1),
        extentOffset: math.min(truncated.length, truncated.length + 1),
      );
    } else if (value.contains(signal)) {
      String tempValue = value.substring(value.indexOf(signal) + 1);
      if (tempValue.contains(signal)) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      }
      if (value.indexOf(signal) == 0) {
        truncated = "0$truncated";
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }
    }
    if (value.contains(" ") || value.contains("-")) {
      truncated = oldValue.text;
      newSelection = oldValue.selection;
    }

    return TextEditingValue(
      text: truncated,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}
