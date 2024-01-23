import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/time_mode.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';
import 'package:portfolio/widgets/market/asset_prices_widget.dart';

void main() {
  // Create a test asset
  Asset testAsset = Asset(
    code: 'TEST',
    prices: {
      AssetDate('2023.1'): const AssetPrice(100.12),
      AssetDate('2023.21'): const AssetPrice.estimated(120.13),
      AssetDate('2023.31'): const AssetPrice(140.0),
    }, // Add test data for prices
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
      expect(find.text('Latest Price: 140.00'), findsOneWidget);
      expect(find.text('Latest Price: 140.00'), findsOneWidget);
    },
  );

  // Test to see if tapping the widget opens the AssetPricesWidget
  testWidgets('Tapping on AssetWidget opens AssetPricesWidget',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: AssetWidget(asset: testAsset),
      ),
    );

    // Find the AssetWidget and simulate a tap
    await tester.tap(find.byType(AssetWidget));
    await tester
        .pumpAndSettle(); // Wait for the navigation animation to complete

    // Check if AssetPricesWidget is displayed
    expect(find.byType(AssetPricesWidget), findsOneWidget);
    // Verify that the specific price is displayed
    expect(find.text('Real: \$120.13'), findsNothing);
  });
}
