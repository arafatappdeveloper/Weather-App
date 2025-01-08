import 'package:intl/intl.dart';

String formateTime(String time){
  DateTime parsetime= DateTime.parse(time);
  return DateFormat('hh:mm a').format(parsetime);
}