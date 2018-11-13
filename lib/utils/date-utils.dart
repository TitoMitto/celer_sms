import 'package:intl/intl.dart';

String formatDate( date,[format='dd/MM/yyyy h:m']){
  var dateTime = (date is String)? DateTime.parse(date): date;
  var formatter = new DateFormat(format);
  String formatted = formatter.format(dateTime);
  return formatted;
}