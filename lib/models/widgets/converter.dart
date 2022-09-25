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
    final _StrIsbn = isbn.toString();
    final _StrIsbn1 = _StrIsbn.substring(0, 3);
    final _StrIsbn2 = _StrIsbn.substring(3, 4);
    final _StrIsbn3 = _StrIsbn.substring(4, 8);
    final _StrIsbn4 = _StrIsbn.substring(8, 12);
    final _StrIsbn5 = _StrIsbn.substring(12, 13);
    final _StrIsbn6 = _StrIsbn1 +
        "-" +
        _StrIsbn2 +
        "-" +
        _StrIsbn3 +
        "-" +
        _StrIsbn4 +
        "-" +
        _StrIsbn5;
    return _StrIsbn6;
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
