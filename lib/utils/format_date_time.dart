import 'package:intl/intl.dart';

String formatToDate(String date) {
  var formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(DateTime.parse(date));
  return formatted;
}
