enum TimeMode { yearWeek }

/// Converts a string representation to a TimeMode enumeration.
///
/// This function maps specific string values to their corresponding TimeMode values.
/// Throws an ArgumentError if the input string does not match any TimeMode.
///
/// Args:
///   str (String): The string representation of the TimeMode.
///
/// Returns:
///   TimeMode: The corresponding TimeMode enumeration.
///
/// Throws:
///   ArgumentError: If the input string does not match any TimeMode.
TimeMode stringToTimeMode(String str) {
  switch (str) {
    case 'year.week':
    case 'year-week':
      return TimeMode.yearWeek;
    default:
      throw ArgumentError('Invalid TimeMode string: $str');
  }
}

/// Converts a TimeMode enumeration to its string representation.
///
/// This function maps specific TimeMode values to their string equivalents.
///
/// Args:
///   mode (TimeMode): The TimeMode enumeration to be converted.
///
/// Returns:
///   String: The string representation of the TimeMode.
String timeModeToString(TimeMode mode) {
  switch (mode) {
    case TimeMode.yearWeek:
      return 'year-week';
    default:
      return '';
  }
}

/// Validates a string based on the specified TimeMode.
///
/// This function switches between different TimeMode validation logic.
/// Currently, it only supports the 'yearWeek' mode.
///
/// Args:
///   mode (TimeMode): The TimeMode enumeration based on which the string will be validated.
///   str (String): The string to be validated.
///
/// Returns:
///   bool: True if the string is valid for the given TimeMode, otherwise false.
bool validateTimeMode(TimeMode mode, String str) {
  switch (mode) {
    case TimeMode.yearWeek:
      return _validateYearWeekTimeMode(str);
    default:
      return false;
  }
}

/// Validates the string to be a year.week string.
///
/// The format is 'YYYY.WW' where YYYY is the year between 1900 and the current year,
/// and WW is the week number, an integer between 1 and 53 (the maximum number of weeks in a year).
///
/// Args:
///   str (String): The string to be validated.
///
/// Returns:
///   bool: True if the string matches the year.week format and falls within valid ranges.
bool _validateYearWeekTimeMode(String str) {
  // Regular expression to match the format
  RegExp regExp = RegExp(r'^(\d{4})\.(\d{1,2})$');

  // Check if the format matches
  if (!regExp.hasMatch(str)) {
    return false;
  }

  // Extract year and week from the string
  var matches = regExp.firstMatch(str);
  var year = int.parse(matches!.group(1)!);
  var week = int.parse(matches.group(2)!);

  // Check if the year is within the valid range (1900 to current year)
  int currentYear = DateTime.now().year;
  if (year < 1900 || year > currentYear) {
    return false;
  }

  // Check if the week is within the valid range (1 to 53)
  if (week < 1 || week > 53) {
    return false;
  }

  // If all conditions are met, the string is valid
  return true;
}
