import 'package:portfolio/models/assets/asset.dart';
import 'package:portfolio/models/assets/asset_date.dart';
import 'package:portfolio/models/assets/asset_price.dart';
import 'package:test/test.dart';

void main() {
  // Generate sample asset with several prices, which are growing.
  Asset asset = Asset(
    code: 'asset',
    prices: {
      AssetDate('2024.1'): const AssetPrice(100.0),
      AssetDate('2024.3'): const AssetPrice(300.0),
      AssetDate('2024.5'): const AssetPrice(500.0),
      AssetDate('2024.7'): const AssetPrice(700.0),
      AssetDate('2024.11'): const AssetPrice(1100.0),
    },
  );

  test(
    "Get highest and lower dates with real value for an Asset.",
    () {
      if (asset.getLatestDateWithRealValue().toString() != '2024.11') {
        fail(
            "The highest date is 2024.11, but we got ${asset.getLatestDateWithRealValue()}");
      }

      if (asset.getOldestDateWithRealValue().toString() != '2024.1') {
        fail(
            "The lowest date is 2024.1, but we got ${asset.getOldestDateWithRealValue()}");
      }
    },
  );

  test(
    "Estimate values",
    () {
      if (asset.estimatePriceValue(AssetDate('2024.2')) != 200) {
        fail(
            "The estimation for 2024.2 is 200, but we got ${asset.estimatePriceValue(AssetDate('2024.2'))}");
      }

      if (asset.estimatePriceValue(AssetDate('2024.4')) != 400) {
        fail(
            "The estimation for 2024.4 is 400, but we got ${asset.estimatePriceValue(AssetDate('2024.2'))}");
      }

      expect(() => asset.estimatePriceValue(AssetDate('2023.3')),
          throwsArgumentError);
      expect(() => asset.estimatePriceValue(AssetDate('2223.3')),
          throwsArgumentError);

      Asset assetWithEstimations = Asset(
        code: 'asset',
        prices: {
          AssetDate('2024.1'): const AssetPrice(100.0),
          AssetDate('2024.3'): const AssetPrice.estimated(3000.0),
          AssetDate('2024.5'): const AssetPrice(500.0),
          AssetDate('2024.7'): const AssetPrice.estimated(7000.0),
          AssetDate('2024.11'): const AssetPrice(1100.0),
        },
      );
      if (assetWithEstimations.estimatePriceValue(AssetDate('2024.2')) != 200) {
        fail(
            "The value estimated apparently did not ignored other estimated values");
      }
      if (assetWithEstimations.estimatePriceValue(AssetDate('2024.10')) !=
          1000) {
        fail(
            "The value estimated apparently did not ignored other estimated values");
      }
      if (assetWithEstimations.estimatePriceValue(AssetDate('2024.11')) !=
          1100) {
        fail(
            "Estimating a 2024.11, with a real value of 1100, should have returned the same. But received ${assetWithEstimations.estimatePriceValue(AssetDate('2024.11'))}");
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
      if (asset.price(AssetDate('2024.1')) != const AssetPrice(100.0)) {
        fail(
            "Value for 2024.1 should be 100.0, but we got ${asset.price(AssetDate('2024.1'))}");
      }
      if (!asset.price(AssetDate('2024.1')).isReal()) {
        fail("Value for 2024.1 is real.");
      }
      if (asset.price(AssetDate('2024.2')) !=
          const AssetPrice.estimated(200.0)) {
        fail(
            "Price for 2024.2 should be 200.0, but we got ${asset.price(AssetDate('2024.2'))}");
      }
      if (!asset.price(AssetDate('2024.2')).isEstimated()) {
        fail("Value for 2024.2 is estimated.");
      }
    },
  );
}
