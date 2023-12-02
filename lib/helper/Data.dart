import 'package:intl/intl.dart';

class DateUtilsFormat {
  static String formatTransactionDate(String inputDate) {
    try {
      // Parse the input date string to a DateTime object
      DateTime parsedDate = DateFormat("yy-MM-dd").parse(inputDate);

      // Format the DateTime object to the desired syntax
      return DateFormat("dd MMMM yyyy").format(parsedDate);
    } catch (e) {
      // Handle any parsing errors, return the original input as a fallback
      return inputDate;
    }
  }
}
