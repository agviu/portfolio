import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:portfolio/widgets/market/asset_list_widget.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';
import 'dart:io';

void main() {
  // Create mock assets
  var assets = [
    Asset(
      code: 'ASSET1',
      prices: {
        AssetDate('2023.1'): const AssetPrice(110.12),
        AssetDate('2023.2'): const AssetPrice.estimated(120.13),
        AssetDate('2023.3'): const AssetPrice(130.0),
        AssetDate('2023.4'): const AssetPrice(140.0),
        AssetDate('2023.5'): const AssetPrice(150.0),
        AssetDate('2023.6'): const AssetPrice(160.0),
        AssetDate('2023.7'): const AssetPrice(170.0),
        AssetDate('2023.8'): const AssetPrice(180.0),
        AssetDate('2023.9'): const AssetPrice(150.0),
        AssetDate('2023.10'): const AssetPrice(200.0),
        AssetDate('2023.11'): const AssetPrice(210.0),
        AssetDate('2023.12'): const AssetPrice(220.0),
      },
    ),
    Asset(
      code: 'ASSET2',
      prices: {
        AssetDate('2023.1'): const AssetPrice(110.12),
        AssetDate('2023.2'): const AssetPrice.estimated(120.13),
        AssetDate('2023.3'): const AssetPrice(130.0),
        AssetDate('2023.4'): const AssetPrice(140.0),
        AssetDate('2023.5'): const AssetPrice(150.0),
        AssetDate('2023.6'): const AssetPrice(160.0),
        AssetDate('2023.7'): const AssetPrice(170.0),
        AssetDate('2023.8'): const AssetPrice(180.0),
        AssetDate('2023.9'): const AssetPrice(190.0),
        AssetDate('2023.10'): const AssetPrice(200.0),
        AssetDate('2023.11'): const AssetPrice(210.0),
        AssetDate('2023.12'): const AssetPrice(230.0),
      },
    ),
  ];

  // Create mock AssetList
  var assetList = AssetList(assets);

  // Test to see if the widget displays a list of assets
  testWidgets(
    'AssetListWidget displays a list of assets',
    (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
            assetList: assetList,
            initialDate: AssetDate.dateTime(DateTime.now()),
          ),
        ),
      );

      // Verify that each asset's code is displayed
      expect(find.text('ASSET1'), findsOneWidget);
      expect(find.text('ASSET2'), findsOneWidget);

      // Verify the presence of AssetWidgets
      expect(find.byType(AssetWidget), findsNWidgets(assets.length));

      // Add more expect statements as needed to validate the UI
    },
  );

  String jsonContent = '';

  setUpAll(
    () async {
      var jsonFile = 'test/models/assets/valid_assets_list.json';
      jsonContent = await File(jsonFile).readAsString();
    },
  );

  testWidgets(
    'Check that asset list is sorted by max growth in the last week when the sort button is pressed',
    (WidgetTester tester) async {
      final AssetList assetList = AssetList.fromJson(jsonContent);

      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
              assetList: assetList, initialDate: AssetDate("2023.48")),
        ),
      );

      // Select the sort menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Select the sort by higher grow by last week option
      await tester.tap(find.text('Higher Growth Last Week'));
      await tester.pumpAndSettle();

      // Check that it is the very first:
      var firstWidgetInList = find.byType(AssetWidget).first;
      var foundWidget = tester.widget(firstWidgetInList);
      var key = foundWidget.key;

      expect(const ValueKey('SHIB').toString(), key.toString());
    },
  );

  testWidgets(
    'Check that asset list is sorted by max growth in the last month when the sort button is pressed',
    (WidgetTester tester) async {
      final AssetList assetList = AssetList.fromJson(jsonContent);

      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
              assetList: assetList, initialDate: AssetDate("2023.48")),
        ),
      );

      // Select the sort menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Select the sort by higher grow by last week option
      await tester.tap(find.text('Higher Growth Last Month'));
      await tester.pumpAndSettle();

      // Check that it is the very first:
      var thirdWidgetInList = find.byType(AssetWidget).at(2);
      var foundWidget = tester.widget(thirdWidgetInList);
      var key = foundWidget.key;

      expect(const ValueKey('BNB').toString(), key.toString());
    },
  );

  testWidgets(
    'Check that asset list is sorted by max growth in the last quarter when the sort button is pressed',
    (WidgetTester tester) async {
      final AssetList assetList = AssetList.fromJson(jsonContent);

      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
              assetList: assetList, initialDate: AssetDate("2023.48")),
        ),
      );

      // Select the sort menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Select the sort by higher grow by last week option
      await tester.tap(find.text('Higher Growth Last Quarter'));
      await tester.pumpAndSettle();

      // Scroll down all the way to the bottom.
      final Finder scrollableFinder = find.byType(Scrollable);
      final ScrollableState scrollableState = tester.state(scrollableFinder);
      double scrollPosition = 0;
      double previousPosition;
      do {
        previousPosition = scrollPosition;
        // Attempt to scroll down by 500 pixels.
        await tester.drag(scrollableFinder, const Offset(0, -500));
        await tester.pumpAndSettle();
        scrollPosition = scrollableState.position.pixels;
      } while (scrollPosition != previousPosition);

      // Check that it is the very last:
      final Finder lastWidgetFinder = find.byType(AssetWidget).last;
      var foundWidget = tester.widget(lastWidgetFinder);
      var key = foundWidget.key;

      expect(const ValueKey('BTC').toString(), key.toString());
    },
  );

  testWidgets(
    'Check what happens when we request a date that is not included in the Asset.',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
            assetList: assetList,
            initialDate: AssetDate('2024.4'),
          ),
        ),
      );

      // Select the sort menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Higher Growth Last Week'));
      await tester.pumpAndSettle();

      expect(find.byType(AssetWidget), findsNothing);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Higher Growth Last Month'));
      await tester.pumpAndSettle();

      expect(find.byType(AssetWidget), findsNothing);

      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Higher Growth Last Quarter'));
      await tester.pumpAndSettle();

      expect(find.byType(AssetWidget), findsNothing);
    },
  );
}
