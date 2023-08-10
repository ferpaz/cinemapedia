import 'package:intl/intl.dart';

class HumanFormats {

  static String formatNumber(double number)
    => NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en',
    ).format( number );
}