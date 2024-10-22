import 'dart:io';

import 'package:intl/intl.dart';

class Formatter {
  static String formatNumber(num value, {int decimalRange = 2, bool showCurrencyPrefix = true}) {
    if (decimalRange == 0) return value.toStringAsFixed(0);

    String formatPattern = '#,##0.${'0' * decimalRange}';
    final String numberFormatted = NumberFormat(formatPattern, Platform.localeName).format(value);
    
    return showCurrencyPrefix ? 'R\$ $numberFormatted' : numberFormatted;
  }

  ///Método para formatar o valor do texto para número
  static num textToNum({required String text, bool isDecimal = true}) {
    if (text.isEmpty) {
      return isDecimal ? 0.0 : 0;
    } else {
      if (isDecimal) {
        if (Platform.localeName == 'pt_BR') {
          text = text.replaceAll('.', '');
          text = text.replaceAll(',', '.');
        } else if (Platform.localeName == 'en_US') {
          text = text.replaceAll(',', '');
        }
        return double.parse(text);
      } else {
        return int.parse(text);
      }
    }
  }

  static String monthYear(DateTime monthYear) {
    return DateFormat('MMM/yyyy', Platform.localeName).format(monthYear);
  }

  static String durationToString(Duration timeToPay) {
    final int hours = timeToPay.inHours;
    final int minutes = timeToPay.inMinutes % 60;

    return '$hours:${minutes.toString().padLeft(2, '0')} ${hours > 1 ? 'hours' : 'hour'}';
  }
}