import 'dart:io';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class TimeFormater {
  String formateDateToLocale() {
    initializeDateFormatting();
    String locale = Platform.localeName;
    return DateFormat('dd/MM/yyyy HH:mm', locale).format(DateTime.now());
  }
}
