import 'package:intl/intl.dart';

String formatDate( date,[format='dd/MM/yyyy h:m']){
  var dateTime = (date is String)? DateTime.fromMillisecondsSinceEpoch(int.parse(date)): date;
  var formatter = new DateFormat(format);
  String formatted = formatter.format(dateTime);
  return formatted;
}