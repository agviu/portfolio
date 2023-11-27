enum TimeMode { yearWeek }

TimeMode stringToTimeMode(String str) {
  switch (str) {
    case 'year.week':
      return TimeMode.yearWeek;
    default:
      throw ArgumentError('Invalid TimeMode string: $str');
  }
}

String timeModeToString(TimeMode mode) {
  switch (mode) {
    case TimeMode.yearWeek:
      return 'year.week';
    default:
      return '';
  }
}

bool validateTimeMode(TimeMode mode, String str) {
  switch (mode) {
    case TimeMode.yearWeek:
      return _validateYearWeekTimeMode(str);
    default:
      return false;
  }
}

/// Validates the string to be a year.week string.
/// The year can be between 1900 and current year
/// The week is an integer between 1 and 53 which is the maximum number of
/// weeks in a year.
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
