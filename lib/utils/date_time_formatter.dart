import 'package:intl/intl.dart';

class DateTimeFormatter {
  static final shared = DateTimeFormatter();

  String dateToString({required DateTime date, String format: "HH:mm"}) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(format);
    return formatter.format(now);
  }

  String timestampToString({required int timestamp, String format: "h:mm a"}) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    DateFormat formatter = DateFormat(format);

    if (date.day == DateTime.now().day) {
      formatter = DateFormat(format);
      ;
    } else if (date.compareTo(DateTime.now()) < 0 &&
        date.year == DateTime.now().year) {
      formatter = DateFormat("EEE, MMM d, yyyy");
    } else if (date.year < DateTime.now().year) {
      formatter = DateFormat("MM/DD/YYYY");
    }

    return formatter.format(date);
  }
}
