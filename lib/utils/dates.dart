import 'package:portfolio/models/time_mode.dart';

/// Set of utilites for managing dates in this app.
class DateUtils {
  /// Returns the last date, depending on the time_mode passed.
  ///
  /// Depending on the mode and from values passed, it will return the
  /// last (higher) value that has happened.
  /// For example, if mode is yearWeek, it will return the last week
  /// that has happened previous to the value passed in from.
  ///
  /// [mode] is the mode to use for getting the last date.
  /// [from] a formatted String that can be used by DateTime.parse
  static dynamic getLastDate(
      {TimeMode mode = TimeMode.yearWeek, String from = 'now'}) {
    final DateTime date;
    if (from == 'now') {
      date = DateTime.now();
    } else {
      date = DateTime.parse(from);
    }

    // Calculates how many days have passed since the begining of the year.
    final DateTime firstDayOfYear = DateTime(date.year, 1, 1);
    final int dayOfYear = date.difference(firstDayOfYear).inDays;

    if (mode == TimeMode.yearWeek) {
      final int weeksSinceStartOfYear = (dayOfYear / 7).floor() + 1;
      List<String> lastDate = [
        date.year.toString(),
        weeksSinceStartOfYear.toString()
      ];
      return lastDate.join('.');
    } else {
      throw UnsupportedError("Only weekYear is supported for now.");
    }
  }
}
