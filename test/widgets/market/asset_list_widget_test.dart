import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_list.dart';
import 'package:portfolio/widgets/market/asset_list_widget.dart';
import 'package:portfolio/widgets/market/asset_widget.dart';

void main() {
  // Create mock assets
  var assets = [
    const Asset(
      code: 'ASSET1',
      prices: {}, // Add test data for prices
      // ... other properties ...
    ),
    const Asset(
      code: 'ASSET2',
      prices: {}, // Add test data for prices
      // ... other properties ...
    ),
  ];

  // Create mock AssetList
  var assetList = AssetList(assets);

  // Test to see if the widget displays a list of assets
  testWidgets('AssetListWidget displays a list of assets',
      (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: AssetListWidget(assetList: assetList),
    ));

    // Verify that each asset's code is displayed
    expect(find.text('ASSET1'), findsOneWidget);
    expect(find.text('ASSET2'), findsOneWidget);

    // Verify the presence of AssetWidgets
    expect(find.byType(AssetWidget), findsNWidgets(assets.length));

    // Add more expect statements as needed to validate the UI
  });
}
