import 'package:intl/intl.dart';

String formatedatetime(String datetime){
   DateTime parseDatetime= DateTime.parse(datetime);
   return DateFormat('dd-MM-yyyy  hh:mm a').format(parseDatetime);
}