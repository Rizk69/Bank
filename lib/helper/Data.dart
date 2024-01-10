import 'package:intl/intl.dart';

class DateUtilsFormat {
  static String formatTransactionDate(String inputDate) {
    try {
      DateTime parsedDate = DateFormat("yy-MM-dd").parse(inputDate);

      return DateFormat("dd MMMM yyyy").format(parsedDate);
    } catch (e) {
      return inputDate;
    }
  }

  static String formatTransactionDateNumber(String inputDate) {
    try {
      DateTime parsedDate = DateFormat("dd.MM.yyyy").parse(inputDate);

      return DateFormat("dd NN yyyy").format(parsedDate);
    } catch (e) {
      return inputDate;
    }
  }
}
