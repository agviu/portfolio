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
    return getLatestsDates(1, mode: mode, from: from).removeLast();
  }

  /// Returns the latest [numberOfTimes] dates, depending on the time_mode passed.
  ///
  /// For example, if mode is yearWeek, it will return the lastest [numberOfTimes] weeks
  /// that has happened previous to the value passed in from.
  ///
  /// [numberOfTimes] is the number of times to return in the list. E.g. number of weeks.
  /// [mode] is the mode to use for getting the last date.
  /// [from] a formatted String that can be used by DateTime.parse
  static List<dynamic> getLatestsDates(int numberOfTimes,
      {TimeMode mode = TimeMode.yearWeek, String from = 'now'}) {
    if (numberOfTimes < 1) {
      throw ArgumentError('numberOfTimes must be at least 1');
    }

    final DateTime fromDate =
        (from == 'now') ? DateTime.now() : DateTime.parse(from);

    /// This function calculates and returns, for [date], the number of the week in the
    /// year that the [date] belongs.
    int getWeekOfYear(DateTime date) {
      // Calculates how many days have passed since the begining of the year.
      final DateTime firstDayOfYear = DateTime(date.year, 1, 1);
      final int dayOfYear = date.difference(firstDayOfYear).inDays;
      final int weekOfYear = (dayOfYear / 7).floor() + 1;
      return weekOfYear;
    }

    if (mode == TimeMode.yearWeek) {
      List<String> weeks = [];
      for (int i = 0; i < numberOfTimes; i++) {
        DateTime targetDate = fromDate.subtract(Duration(days: 7 * i));
        int weekOfYear = getWeekOfYear(targetDate);
        weeks.add('${targetDate.year}.$weekOfYear');
      }
      return weeks;
    } else {
      throw UnsupportedError("Only weekYear is supported for now.");
    }
  }
}
