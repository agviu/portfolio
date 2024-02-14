import 'package:portfolio/models/time_mode.dart';

/// A utility class for managing and manipulating dates within the application.
/// Supports operations based on different time modes, currently focused on `TimeMode.yearWeek`.
class AssetDate {
  final TimeMode mode;
  final DateTime _dateTime;
  late final String _date;

  /// Constructs an AssetDate object from a formatted date string.
  /// Throws FormatException if the date string is not in the expected format.
  ///
  /// [date]: A formatted date string (e.g., 'YYYY.WW').
  /// [mode]: The time mode to interpret the date, defaulting to `TimeMode.yearWeek`.
  AssetDate(String date, {this.mode = TimeMode.yearWeek})
      : _dateTime = _parseDate(date, mode) {
    if (mode == TimeMode.yearWeek) {
      // We check if the week is between 1 and 9 and remove a 0 in the left if it exists.
      if (!validateTimeMode(mode, date)) {
        throw const FormatException('Invalid format. Expected format: YYYY.WW');
      }

      var parts = date.split('.');
      int week = int.tryParse(parts[1]) ?? 0;
      _date = '${parts[0]}.${week.toString()}';
    }
  }

  /// Constructs an AssetDate object from a DateTime object.
  ///
  /// [dateTime]: A DateTime object.
  /// [mode]: The time mode, defaulting to `TimeMode.yearWeek`.
  AssetDate.dateTime(DateTime dateTime, {this.mode = TimeMode.yearWeek})
      : _dateTime = dateTime,
        _date = '${dateTime.year}.${_getWeekOfYear(dateTime)}';

  DateTime get dateTime => _dateTime;
  String get date => _date;

  /// Parses a date string according to the specified time mode.
  ///
  /// This function takes a date string and a time mode, and converts the string
  /// into a DateTime object. Currently, it only supports the `TimeMode.yearWeek` mode,
  /// which expects the date string to be in the format 'YYYY.WW' (Year and Week of Year).
  ///
  /// Throws:
  /// - [FormatException] if the date string is not in the expected format or
  ///   if the year or week number is invalid (e.g., week number > 53).
  /// - [UnsupportedError] if a time mode other than `TimeMode.yearWeek` is provided.
  ///
  /// Arguments:
  /// - [date]: A date string in the format specified by the [mode].
  /// - [mode]: The time mode that determines how the date string should be parsed.
  ///   Currently, only `TimeMode.yearWeek` is supported.
  ///
  /// Returns:
  /// A [DateTime] object representing the start of the specified week of the year.
  /// For `TimeMode.yearWeek`, it computes the DateTime corresponding to the first day
  /// of the specified week number in the given year.
  ///
  /// Example:
  /// ```
  /// var dateTime = _parseDate('2023.10', TimeMode.yearWeek);
  /// // Returns a DateTime object representing the start of the 10th week of 2023.
  /// ```
  static DateTime _parseDate(String date, TimeMode mode) {
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

      final firstDayOfYear = DateTime(year, 1, 1);
      final dayOfYear = (week - 1) * 7;

      return firstDayOfYear.add(Duration(days: dayOfYear));
    }

    throw UnsupportedError("Only weekYear is supported for now.");
  }

  /// Calculates the week number of the year for a given date.
  ///
  /// This function determines the week number within the year to which the
  /// specified date belongs. The calculation is based on the number of days
  /// that have passed since the beginning of the year. It assumes a simple model
  /// where the first week starts on January 1st and each week is exactly 7 days long.
  ///
  /// Note: This calculation does not conform to ISO 8601 week numbering.
  /// In ISO 8601, the first week of the year is the week with the year's first Thursday in it.
  ///
  /// Arguments:
  /// - [dateTime]: The date for which the week number is to be calculated.
  ///
  /// Returns:
  /// An [int] representing the week number of the year for the given date.
  /// The week number starts from 1.
  ///
  /// Example:
  /// ```
  /// var weekNumber = _getWeekOfYear(DateTime(2023, 1, 10));
  /// // Returns the week number of January 10, 2023.
  /// ```
  static int _getWeekOfYear(DateTime dateTime) {
    // Calculates how many days have passed since the begining of the year.
    final DateTime firstDayOfYear = DateTime(dateTime.year, 1, 1);
    final int dayOfYear = dateTime.difference(firstDayOfYear).inDays;
    final int weekOfYear = (dayOfYear / 7).floor() + 1;
    return weekOfYear;
  }

  /// Returns the most recent date based on the current [mode].
  ///
  /// This function calculates the most recent date based on the current [mode].
  /// When using `TimeMode.yearWeek`, it calculates the most recent week that occurred before the current date.
  ///
  /// Returns:
  /// An [AssetDate] object representing the most recent date.
  AssetDate getLastDate() {
    return getLatestsDates(1).first;
  }

  /// Returns a list of the most recent dates based on the given [numberOfTimes].
  ///
  /// This function calculates the latest dates based on the specified [numberOfTimes] and the current [mode].
  /// When using `TimeMode.yearWeek`, it calculates the latest weeks that occurred before the current date.
  ///
  /// Arguments:
  /// - [numberOfTimes]: The number of times to return dates, must be at least 1.
  ///
  /// Returns:
  /// A list of [AssetDate] objects representing the most recent dates, ordered from most recent to less recent.
  ///
  /// Throws:
  /// - [ArgumentError] if [numberOfTimes] is less than 1.
  /// - [UnsupportedError] if the [mode] is not `TimeMode.yearWeek`.
  ///
  /// Example:
  /// ```
  /// var latestWeeks = getLatestsDates(3);
  /// // Returns a list of the 3 most recent weeks prior to the current date.
  /// ```
  List<AssetDate> getLatestsDates(int numberOfTimes) {
    if (numberOfTimes < 1) {
      throw ArgumentError('numberOfTimes must be at least 1');
    }

    if (mode == TimeMode.yearWeek) {
      List<AssetDate> weeks = [];
      for (int i = 1; i <= numberOfTimes; i++) {
        weeks.add(_getNewDate(Duration(days: -7 * i)));
      }
      return weeks;
    } else {
      throw UnsupportedError("Only yearWeek is supported for now.");
    }
  }

  /// Generates a new [AssetDate] by adding the specified [duration] to the current date.
  ///
  /// This function calculates a new [AssetDate] by adding the given [duration] to the current date.
  /// The resulting date will depend on the current [mode] of the [AssetDate].
  ///
  /// Parameters:
  /// - [duration]: The duration to add to the current date.
  ///
  /// Returns:
  /// An [AssetDate] object representing the new date after adding the [duration].
  ///
  /// Example:
  /// ```
  /// var nextWeek = _getNewDate(const Duration(days: 7));
  /// // Returns an [AssetDate] object representing the date one week ahead of the current date.
  /// ```
  AssetDate _getNewDate(Duration duration) {
    DateTime newDateTime = dateTime.add(duration);
    return AssetDate.dateTime(newDateTime, mode: mode);
  }

  /// Computes and returns the next date, considering the current time mode.
  ///
  /// This function calculates and returns the next date based on the current [mode].
  /// It increments the date by one week if the mode is [TimeMode.yearWeek].
  ///
  /// Returns:
  /// An [AssetDate] object representing the next date.
  ///
  /// Throws:
  /// - [UnsupportedError]: If the current [mode] is not [TimeMode.yearWeek].
  ///
  /// Example:
  /// ```
  /// var nextDate = getNextDate();
  /// // Returns an [AssetDate] object representing the date one week ahead of the current date.
  /// ```
  AssetDate getNextDate() {
    if (mode == TimeMode.yearWeek) {
      return _getNewDate(const Duration(days: 7));
    }

    throw UnsupportedError("Only yearWeek is supported for now.");
  }

  /// Computes and returns the previous date, considering the current time mode.
  ///
  /// This function calculates and returns the previous date based on the current [mode].
  /// It decrements the date by one week if the mode is [TimeMode.yearWeek].
  ///
  /// Returns:
  /// An [AssetDate] object representing the previous date.
  ///
  /// Throws:
  /// - [UnsupportedError]: If the current [mode] is not [TimeMode.yearWeek].
  ///
  /// Example:
  /// ```
  /// var previousDate = getPreviousDate();
  /// // Returns an [AssetDate] object representing the date one week before the current date.
  /// ```
  AssetDate getPreviousDate() {
    if (mode == TimeMode.yearWeek) {
      return _getNewDate(const Duration(days: -7));
    }

    throw UnsupportedError("Only yearWeek is supported for now.");
  }

  /// Override of the equality operator.
  /// Determines if two AssetDate instances are equal based on the _date property.
  ///
  /// Args:
  ///   other (Object): The object to compare with the current instance.
  ///
  /// Returns:
  ///   bool: True if the other object is an AssetDate instance and
  ///   has the same _date value, false otherwise.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AssetDate && other._date == _date;
  }

  /// Override of the hashCode getter.
  /// Provides a hash code for an AssetDate instance based on the _date property.
  ///
  /// Returns:
  ///   int: The hash code for the AssetDate instance.
  @override
  int get hashCode => _date.hashCode;

  /// Override of the toString parent method.
  ///
  /// Returns the date, as it is the string representation of this class.
  @override
  String toString() {
    return _date;
  }
}
