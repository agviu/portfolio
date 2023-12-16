import 'package:test/test.dart';
import 'package:portfolio/utils/dates.dart';
// import 'package:portfolio/models/time_mode.dart';

void main() {
  // const TimeMode mode = TimeMode.yearWeek;

  test(
    'Gets the latest values',
    () {
      // First week of the year:
      var date = DateTime(2024, 1, 1);
      var dateString = date.toString();
      var lastDate = DateUtils.getLastDate(from: dateString);
      if (lastDate != '2024.1') {
        fail("For the date 2024-1-1 we expect 2024.1, but received $lastDate");
      }

      // Fourth week of the year:
      date = DateTime(2024, 1, 21);
      dateString = date.toString();
      lastDate = DateUtils.getLastDate(from: dateString);
      if (lastDate != '2024.3') {
        fail("For the date 2024-1-21 we expect 2024.3, but received $lastDate");
      }

      // Check that passing now also works:
      date = DateTime.now();
      dateString = date.toString();
      lastDate = DateUtils.getLastDate(from: dateString);
      var lastDateNow = DateUtils.getLastDate(from: 'now');
      if (lastDate != lastDateNow) {
        fail(
            "When checking for now, the lastDate was $lastDateNow but we expected $lastDate");
      }
    },
  );

  test(
    'Get several last weeks',
    () {
      // Get the last 2 weeks from 16/12/2023
      var date = DateTime(2023, 12, 16);
      var dateString = date.toString();
      var weeks = DateUtils.getLatestsDates(2, from: dateString);
      if (weeks.length != 2) {
        fail("Expecting 2 weeks, received ${weeks.length}");
      } else {
        var firstWeek = weeks[0];
        var secondWeek = weeks[1];
        if (firstWeek != '2023.50' && secondWeek != '2023.49') {
          fail("The values of the last 2 weeks do not match");
        }
      }

      // Get the last 6 weeks from 16/2/2023
      date = DateTime(2023, 1, 16);
      dateString = date.toString();
      weeks = DateUtils.getLatestsDates(6, from: dateString);
      if (weeks.length != 6) {
        fail("Expecting 6 weeks, received ${weeks.length}");
      } else {
        var firstWeek = weeks[0];
        var fourthWeek = weeks[3];
        if (firstWeek != '2023.3' && fourthWeek != '2022.52') {
          fail("The values of 2 weeks do not match");
        }
      }

      // Get last 4 months of weeks
      dateString = DateTime(2024, 3, 23).toString();
      weeks = DateUtils.getLatestsDates(4 * 4, from: dateString);
      if (weeks.length != 16) {
        fail("Expecting 16 weeks, but received ${weeks.length}");
      }
      if (weeks[0] != '2024.12' && weeks[15] != '2023.49') {
        fail("The values of 2 weeks do not match");
      }

      // Check that the function returns an Exception is number of times is not 1 or bigger number.
      expect(() {
        DateUtils.getLatestsDates(0);
      }, throwsArgumentError);
    },
  );
}
