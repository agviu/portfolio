import 'package:test/test.dart';
import 'package:portfolio/utils/dates.dart';
import 'package:portfolio/models/time_mode.dart';

void main() {
  const TimeMode mode = TimeMode.yearWeek;

  test('Gets the latest values', () {
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
  });
}
