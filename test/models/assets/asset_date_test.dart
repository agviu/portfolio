import 'package:test/test.dart';
// import 'package:portfolio/models/assets/asset_date.dart';
// // import 'package:portfolio/models/time_mode.dart';

// void main() {
//   // const TimeMode mode = TimeMode.yearWeek;

//   test(
//     'Gets the latest values',
//     () {
//       // First week of the year:
//       var date = DateTime(2024, 1, 1);
//       var dateString = date.toString();
//       var lastDate = DateUtils.getLastDate(from: dateString);
//       if (lastDate != '2024.1') {
//         fail("For the date 2024-1-1 we expect 2024.1, but received $lastDate");
//       }

//       // Fourth week of the year:
//       date = DateTime(2024, 1, 21);
//       dateString = date.toString();
//       lastDate = DateUtils.getLastDate(from: dateString);
//       if (lastDate != '2024.3') {
//         fail("For the date 2024-1-21 we expect 2024.3, but received $lastDate");
//       }

//       // Check that passing now also works:
//       date = DateTime.now();
//       dateString = date.toString();
//       lastDate = DateUtils.getLastDate(from: dateString);
//       var lastDateNow = DateUtils.getLastDate(from: 'now');
//       if (lastDate != lastDateNow) {
//         fail(
//             "When checking for now, the lastDate was $lastDateNow but we expected $lastDate");
//       }
//     },
//   );

//   test(
//     'Get several last weeks',
//     () {
//       // Get the last 2 weeks from 16/12/2023
//       var date = DateTime(2023, 12, 16);
//       var dateString = date.toString();
//       var weeks = DateUtils.getLatestsDates(2, from: dateString);
//       if (weeks.length != 2) {
//         fail("Expecting 2 weeks, received ${weeks.length}");
//       } else {
//         var firstWeek = weeks[0];
//         var secondWeek = weeks[1];
//         if (firstWeek != '2023.50' && secondWeek != '2023.49') {
//           fail("The values of the last 2 weeks do not match");
//         }
//       }

//       // Get the last 6 weeks from 16/2/2023
//       date = DateTime(2023, 1, 16);
//       dateString = date.toString();
//       weeks = DateUtils.getLatestsDates(6, from: dateString);
//       if (weeks.length != 6) {
//         fail("Expecting 6 weeks, received ${weeks.length}");
//       } else {
//         var firstWeek = weeks[0];
//         var fourthWeek = weeks[3];
//         if (firstWeek != '2023.3' && fourthWeek != '2022.52') {
//           fail("The values of 2 weeks do not match");
//         }
//       }

//       // Get last 4 months of weeks
//       dateString = DateTime(2024, 3, 23).toString();
//       weeks = DateUtils.getLatestsDates(4 * 4, from: dateString);
//       if (weeks.length != 16) {
//         fail("Expecting 16 weeks, but received ${weeks.length}");
//       }
//       if (weeks[0] != '2024.12' && weeks[15] != '2023.49') {
//         fail("The values of 2 weeks do not match");
//       }

//       // Check that the function returns an Exception is number of times is not 1 or bigger number.
//       expect(() {
//         DateUtils.getLatestsDates(0);
//       }, throwsArgumentError);
//     },
//   );

//   test(
//     'Test getting next week',
//     () {
//       String nextWeek = DateUtils.getNextDate('2023.2');
//       if (nextWeek != '2023.3') {
//         fail('Next week should have been 2023.3, but received $nextWeek');
//       }
//       nextWeek = DateUtils.getNextDate('2023.52');
//       if (nextWeek != '2023.53') {
//         fail('Next week should have been 2023.53, but received $nextWeek');
//       }
//       nextWeek = DateUtils.getNextDate('2023.53');
//       if (nextWeek != '2024.1') {
//         fail('Next week should have been 2024.1, but received $nextWeek');
//       }
//       nextWeek = DateUtils.getNextDate('2022.52');
//       if (nextWeek != '2023.1') {
//         fail('Next week should have been 2023.1, but received $nextWeek');
//       }
//     },
//   );

//   test(
//     'Test getting previous week',
//     () {
//       String previousWeek = DateUtils.getPreviousDate('2023.2');
//       if (previousWeek != '2023.1') {
//         fail(
//             'Previous week should have been 2023.1, but received $previousWeek');
//       }
//       previousWeek = DateUtils.getPreviousDate('2023.1');
//       if (previousWeek != '2022.52') {
//         fail(
//             'Previous week should have been 2022.52, but received $previousWeek');
//       }
//       previousWeek = DateUtils.getPreviousDate('2024.1');
//       if (previousWeek != '2023.53') {
//         fail(
//             'Previous week should have been 2023.53, but received $previousWeek');
//       }
//     },
//   );
// }

import 'package:portfolio/models/assets/asset_date.dart'; // Import your AssetDate class

void main() {
  group('AssetDate Tests', () {
    test('Constructor with valid year.week format', () {
      var assetDate = AssetDate('2023.10');
      expect(assetDate.date, equals('2023.10'));
      // You might also want to check the dateTime property for correctness
    });

    test('Constructor with invalid format throws FormatException', () {
      expect(() => AssetDate('2023-10'), throwsFormatException);
    });

    test('Constructor with DateTime object', () {
      var dateTime = DateTime(2023, 1, 10);
      var assetDate = AssetDate.dateTime(dateTime);
      // Assuming your week calculation logic is correct,
      // this should be the 2nd week of 2023
      expect(assetDate.date, equals('2023.2'));
    });

    test('getLastDate returns correct recent date', () {
      var assetDate = AssetDate('2023.10');
      var lastDate = assetDate.getLastDate();
      // Check if lastDate is correct
      expect(lastDate.date, equals('2023.9'));
    });

    test('getLatestsDates with valid number of times', () {
      var assetDate = AssetDate('2023.10');
      var latestDates = assetDate.getLatestsDates(3);
      expect(latestDates.length, equals(3));

      // Check that the list contains the correct dates
      expect(latestDates[0].date, equals('2023.9'));
      expect(latestDates[1].date, equals('2023.8'));
      expect(latestDates[2].date, equals('2023.7'));

      // Print the list for debugging purposes
      // print(latestDates.map((d) => d.date).toList());
    });

    test('getLatestsDates with invalid number of times throws ArgumentError',
        () {
      var assetDate = AssetDate('2023.10');
      expect(() => assetDate.getLatestsDates(0), throwsArgumentError);
    });

    test('getNextDate returns correct next date', () {
      var assetDate = AssetDate('2023.10');
      var nextDate = assetDate.getNextDate();
      // Check if nextDate is correct
      expect(nextDate.date, equals('2023.11'));
    });

    test('getPreviousDate returns correct previous date', () {
      var assetDate = AssetDate('2023.10');
      var previousDate = assetDate.getPreviousDate();
      // Check if previousDate is correct
      expect(previousDate.date, equals('2023.9'));
    });

    // Add more tests as needed to cover other aspects or edge cases
  });
}
