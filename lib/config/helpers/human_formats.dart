import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number, [int decimalPlaces = 0]) {
    final formattedNumber = NumberFormat.compactCurrency(
            decimalDigits: decimalPlaces, symbol: '', locale: 'en')
        .format(number);

    return formattedNumber;
  }
}
