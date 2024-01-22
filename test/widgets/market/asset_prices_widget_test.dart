import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:portfolio/widgets/market/asset_prices_widget.dart';

void main() {
  // Create test data
  Asset testAsset = Asset(
    code: 'TEST',
    prices: {
      AssetDate('2023.1'): const AssetPrice(100.0),
      AssetDate('2023.21'): const AssetPrice.estimated(120.0),
    },
    // ... other properties ...
  );

  // Test to see if the widget displays the asset code and prices
  testWidgets(
    'AssetPricesWidget displays the asset code and prices',
    (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: AssetPricesWidget(asset: testAsset),
        ),
      );

      // Verify that the asset's code is displayed
      expect(find.text('TEST'), findsOneWidget);

      // Verify that the prices are displayed
      expect(find.text('Real: \$100.0'), findsOneWidget);
      expect(find.text('Estimated: \$120.0'), findsOneWidget);
      expect(find.text('2023.1'), findsOneWidget);
      expect(find.text('2023.21'), findsOneWidget);
    },
  );
}
