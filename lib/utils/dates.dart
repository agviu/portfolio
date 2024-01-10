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

  /// Returns the next date, considering also swith to next year if needed.
  /// E.g. if [date] is 2023.3, it will return 2023.4.
  /// If it reaches the end of the year, will get the first week of next year.
  static String getNextDate(String date, {TimeMode mode = TimeMode.yearWeek}) {
    if (mode == TimeMode.yearWeek) {
      var parts = date.split('.');
      if (parts.length != 2) {
        throw const FormatException('Invalid format. Expected format: YYYY.WW');
      }

      int year = int.tryParse(parts[0]) ?? 0;
      int week = int.tryParse(parts[1]) ?? 0;

      if (year < 1 || week < 1 || week > 53) {
        throw const FormatException('Invalid year or week number.');
      }

      // Check if the year has 52 or 53 weeks
      int weeksInYear = has53Weeks(year) ? 53 : 52;

      // Increment the week, rolling over to the next year if necessary
      if (week < weeksInYear) {
        week++;
      } else {
        week = 1;
        year++;
      }

      return '$year.${week.toString()}';
    } else {
      throw UnsupportedError("Only weekYear is supported for now.");
    }
  }

  /// Returns the previous date, considering also swith to previous year if needed.
  /// E.g. if [date] is 2023.4, it will return 2023.3.
  /// If it reaches the begining of the year, will get the first week of previous year.
  static String getPreviousDate(String date,
      {TimeMode mode = TimeMode.yearWeek}) {
    if (mode == TimeMode.yearWeek) {
      var parts = date.split('.');
      if (parts.length != 2) {
        throw const FormatException('Invalid format. Expected format: YYYY.WW');
      }

      int year = int.tryParse(parts[0]) ?? 0;
      int week = int.tryParse(parts[1]) ?? 0;

      if (year < 1 || week < 1 || week > 53) {
        throw const FormatException('Invalid year or week number.');
      }

      // Decrement the week, rolling over to the previous year if necessary
      if (week > 1) {
        week--;
      } else {
        year--;
        // Check if the previous year has 52 or 53 weeks
        int weeksInPreviousYear = has53Weeks(year) ? 53 : 52;
        week = weeksInPreviousYear;
      }

      return '$year.${week.toString()}';
    } else {
      throw UnsupportedError("Only weekYear is supported for now.");
    }
  }

  /// Calculates if the [year] has 53 weeks
  static bool has53Weeks(int year) {
    // A year has 53 weeks if it starts on Thursday or is a leap year that starts on Wednesday
    var dec28 = DateTime(year, 12, 28);
    return dec28.weekday == DateTime.thursday ||
        (DateTime(year).isLeapYear && dec28.weekday == DateTime.wednesday);
  }
}

extension on DateTime {
  // Helper method to check if a year is a leap year
  bool get isLeapYear => year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}

/// Compares two dates formatted as 'Number1.Number2' strings.
///
/// This function is designed to compare strings that are formatted
/// with two integers separated by a dot. The comparison is primarily
/// based on the first integer (Number1). If the first integers are equal,
/// the second integers (Number2) are compared.
///
/// The comparison is numerical, meaning '2002.10' is considered greater
/// than '2002.9' (contrary to lexicographical string comparison).
///
/// Usage:
/// ```
/// compareDates('2002.23', '2002.24'); // Returns -1
/// compareDates('2002.25', '2002.24'); // Returns 1
/// compareDates('2001.24', '2002.24'); // Returns -1
/// compareDates('2002.24', '2002.24'); // Returns 0
/// ```
///
/// Arguments:
/// [date1] : The first formatted string to compare.
/// [date2] : The second formatted string to compare.
///
/// Returns:
/// An [int] indicating the comparison result:
/// - A negative number if [date1] is less than [date2].
/// - Zero if [date1] is equal to [date2].
/// - A positive number if [date1] is greater than [date2].
int compareDates(String date1, String date2,
    {TimeMode mode = TimeMode.yearWeek}) {
  if (mode == TimeMode.yearWeek) {
    // Split the strings into parts
    var parts1 = date1.split('.');
    var parts2 = date2.split('.');

    // Convert the parts into integers
    int num1Part1 = int.parse(parts1[0]);
    int num2Part1 = int.parse(parts2[0]);

    // Compare the first parts
    if (num1Part1 != num2Part1) {
      return num1Part1.compareTo(num2Part1);
    }

    // Convert the parts into integers
    int num1Part2 = int.parse(parts1[1]);
    int num2Part2 = int.parse(parts2[1]);

    // If the first parts are equal, compare the second parts
    return num1Part2.compareTo(num2Part2);
  } else {
    // By default, use the standard string comparision.
    return date1.compareTo(date2);
  }
}
