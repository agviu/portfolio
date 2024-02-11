import 'package:test/test.dart';
import 'package:portfolio/models/time_mode.dart';

void main() {
  test(
    'test stringToTimeMode',
    () {
      // Test with valid input
      var result = stringToTimeMode('year.week');
      assert(result == TimeMode.yearWeek,
          'Valid input did not return expected TimeMode');

      // Test with invalid input
      try {
        stringToTimeMode('invalid.input');
        assert(false, 'Invalid input should throw ArgumentError');
      } catch (e) {
        assert(e is ArgumentError, 'Expected ArgumentError for invalid input');
      }
    },
  );

  test(
    'test timeModeToString',
    () {
      // Test with valid TimeMode
      var result = timeModeToString(TimeMode.yearWeek);
      assert(result == 'year-week',
          'TimeMode.yearWeek did not return expected string');

      // Test with an undefined or default case
      // Depending on how TimeMode is defined, you might need to add a case here
    },
  );

  test(
    'test validateTimeMode',
    () {
      // Assuming TimeMode.yearWeek is a valid enumeration value in your code
      TimeMode testMode = TimeMode.yearWeek;

      // Test with valid year and week
      assert(validateTimeMode(testMode, '2023.10'),
          'Valid year.week format should return true');

      // Test with invalid year (outside range)
      assert(!validateTimeMode(testMode, '1899.10'),
          'Year outside valid range should return false');
      assert(!validateTimeMode(testMode, '${DateTime.now().year + 1}.10'),
          'Future year should return false');

      // Test with invalid week (outside range)
      assert(!validateTimeMode(testMode, '2023.0'),
          'Week number below 1 should return false');
      assert(!validateTimeMode(testMode, '2023.54'),
          'Week number above 53 should return false');

      // Test with invalid format
      assert(!validateTimeMode(testMode, '2023-10'),
          'Invalid format should return false');
      assert(!validateTimeMode(testMode, 'abc.def'),
          'Non-numeric format should return false');
    },
  );
}
