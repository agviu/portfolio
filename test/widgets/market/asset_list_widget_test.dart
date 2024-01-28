import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:portfolio/widgets/market/asset_list_widget.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';

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

  testWidgets(
    'Check that asset list is sorted by max growth in the last week when the sort button is pressed',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
              assetList: assetList, initialDate: AssetDate('2023.12')),
        ),
      );

      // Select the sort menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Select the sort by higher grow by last week option
      await tester.tap(find.text('Higher Growth Last Week'));
      await tester.pumpAndSettle();

      var finderWidget = find.byKey(const ValueKey('ASSET2'));
      // Check that the sort happened.
      await tester.scrollUntilVisible(
        finderWidget,
        1,
        scrollable: find.byType(Scrollable),
      );

      expect(finderWidget, findsOneWidget);
    },
  );

  testWidgets(
    'Check that asset list is sorted by max growth in the last month when the sort button is pressed',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AssetListWidget(
            assetList: assetList,
            initialDate: AssetDate('2023.12'),
          ),
        ),
      );

      // Select the sort menu
      await tester.tap(find.byType(PopupMenuButton<String>));
      await tester.pumpAndSettle();

      // Select the sort by higher grow by last month option
      await tester.tap(find.text('Higher Growth Last Month'));
      await tester.pumpAndSettle();

      var finderWidget = find.byType(AssetWidget);
      // Check that the sort happened.
      await tester.scrollUntilVisible(
        finderWidget,
        1,
        scrollable: find.byType(Scrollable),
      );

      expect(finderWidget, findsOneWidget);
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

      // Select the sort by higher grow by last month option
      await tester.tap(find.text('Higher Growth Last Month'));
      await tester.pumpAndSettle();

      // var finderWidget = find.byType(AssetWidget);
      // // Check that the sort happened.
      // await tester.scrollUntilVisible(
      //   finderWidget,
      //   1,
      //   scrollable: find.byType(Scrollable),
      // );

      // expect(finderWidget, findsOneWidget);
    },
  );
}
