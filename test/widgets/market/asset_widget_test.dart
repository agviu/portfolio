import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/time_mode.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';

void main() {
  // Create a test asset
  Asset testAsset = const Asset(
    code: 'TEST',
    prices: {}, // Add test data for prices
    category:
        Category.crypto, // Example category, replace with actual enum value
    mode:
        TimeMode.yearWeek, // Example time mode, replace with actual enum value
  );

  // Test to see if the widget is built and displays the asset code correctly
  testWidgets(
    'AssetWidget displays the asset information',
    (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: AssetWidget(
            asset: testAsset,
          ),
        ),
      );

      // Verify that the asset's code is displayed
      expect(find.text('TEST'), findsOneWidget);

      // Add more expects to verify other parts of your widget
      // For example, category and time mode display
    },
  );

  // Test to see if tapping the widget opens the AssetPricesWidget
  testWidgets(
    'Tapping on AssetWidget opens AssetPricesWidget',
    (WidgetTester tester) async {
      // Implement this test based on your navigation logic and expected behavior
    },
  );
}
