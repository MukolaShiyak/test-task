import 'dart:io';

import 'package:intl/intl.dart';

class TimeFormater {
  String formateDateToLocale() {
    String locale = Platform.localeName;
    return DateFormat('dd/MM/yyyy HH:mm', locale).format(DateTime.now());
  }
}
