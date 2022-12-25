import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

String dateToString(DateTime? date) {
  if (date == null) {
    return "----------";
  } else {
    return DateFormat('dd.MM.yy').format(date);
  }
}

String isbnFormat(int isbn) {
  if (isbn.toString().length == 13) {
    final strIsbn = isbn.toString();
    final strIsbn1 = strIsbn.substring(0, 3);
    final strIsbn2 = strIsbn.substring(3, 4);
    final strIsbn3 = strIsbn.substring(4, 8);
    final strIsbn4 = strIsbn.substring(8, 12);
    final strIsbn5 = strIsbn.substring(12, 13);
    final strIsbn6 = "$strIsbn1-$strIsbn2-$strIsbn3-$strIsbn4-$strIsbn5";
    return strIsbn6;
  } else {
    return "Wong ISBN";
  }
}

DateTime stringToDate(String date) {
  if (date == "") {
    return DateFormat("").parse(date);
  } else {
    return DateFormat("dd.MM.yyyy").parse(date);
  }
}

String getTitle(int inEditMode) {
  if (inEditMode == 1) {
    return "Edit Book";
  } else {
    return "Add Book";
  }
}

String isSeries(String title, bool series, int volume) {
  if (series) {
    return "$title Band: $volume";
  } else {
    return title;
  }
}

class ChartData {
  final int value;
  final String title;
  final charts.Color barColor;

  ChartData({
    required this.value,
    required this.title,
    required this.barColor,
  });
}
