import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:test/test.dart';

void main() {
  // Generate sample asset with several prices, which are growing.
  Asset asset = const Asset(
    code: 'asset',
    prices: {
      '2024.1': AssetPrice(100.0),
      '2024.3': AssetPrice(300.0),
      '2024.5': AssetPrice(500.0),
      '2024.7': AssetPrice(700.0),
      '2024.11': AssetPrice(1100.0),
    },
  );

  test(
    "Get highest and lower dates with real value for an Asset.",
    () {
      if (asset.getHighestDateWithRealValue() != '2024.11') {
        fail(
            "The highest date is 2024.11, but we got ${asset.getHighestDateWithRealValue()}");
      }

      if (asset.getLowestDateWithRealValue() != '2024.1') {
        fail(
            "The lowest date is 2024.1, but we got ${asset.getLowestDateWithRealValue()}");
      }
    },
  );

  test(
    'Asset is created with specific prices',
    () {
      // // Generate sample asset with several prices, which are growing.
      // Asset asset = const Asset(
      //   code: 'asset',
      //   prices: {
      //     '2024.1': AssetPrice(100.0),
      //     '2024.3': AssetPrice(300.0),
      //     '2024.5': AssetPrice(500.0),
      //     '2024.7': AssetPrice(700.0),
      //     '2024.11': AssetPrice(1100.0),
      //   },
      // );
      if (asset.price('2024.1') != const AssetPrice(100.0)) {
        fail(
            "Value for 2024.1 should be 100.0, but we got ${asset.price('2024.1')}");
      }
      if (!asset.price('2024.1').isReal()) {
        fail("Value for 2024.1 is real.");
      }
      if (asset.price('2024.2') != const AssetPrice.estimated(200.0)) {
        fail(
            "Price for 2024.2 should be 200.0, but we got ${asset.price('2024.2')}");
      }
      if (!asset.price('2024.2').isEstimated()) {
        fail("Value for 2024.2 is estimated.");
      }
    },
  );
}
