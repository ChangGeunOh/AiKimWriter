import 'package:intl/intl.dart';

class Utils {
  static String getFormattedDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    final DateFormat formatter = DateFormat('yyyy/MM/dd');
    return formatter.format(dateTime);
  }

  static String getFormattedDateWithFormat({
    required DateTime dateTime,
    String format = 'yyyy.MM.dd',
  }) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }


  static getNumberWithComma(int number) {
    return NumberFormat('#,###').format(number);
  }

  static getNumberWithPercent(int number, int total) {
    if (total == 0) return '0%';
    return '${NumberFormat('#,###.0').format(number / total * 100)}%';
  }

  static String getPercent(double number) {
    return '${NumberFormat('#,##0.0').format(number)}%';
  }
}
