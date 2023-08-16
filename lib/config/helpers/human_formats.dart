import 'package:intl/intl.dart';

class HumanFormats {

  static String formatCompactNumber(double number)
    => NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en',
    ).format( number );

  static String formatNumber(double number)
    => NumberFormat.currency(
      decimalDigits: 1,
      symbol: '',
      locale: 'en',
    ).format( number );

  static String formatDate(DateTime date)
    => DateFormat('d/M/yyyy').format(date);

}