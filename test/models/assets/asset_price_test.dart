import 'package:test/test.dart';
import 'package:portfolio/models/assets/asset_price.dart';

void main() {
  group(
    'AssetPrice',
    () {
      test('getValue() should return real value if it exists', () {
        const assetPrice = AssetPrice(100.0);
        expect(assetPrice.getValue(), equals(100.0));
      });
      test('getValue() should return estimated value if it exists', () {
        const assetPrice = AssetPrice.estimated(150.0);
        expect(assetPrice.getValue(), equals(150.0));
      });

      test(
          'getValue() should throw StateError if neither real nor estimated value exists',
          () {
        const assetPrice = AssetPrice(null);
        expect(() => assetPrice.getValue(), throwsStateError);
      });

      test('getRealValue() should return real value if it exists', () {
        const assetPrice = AssetPrice(100.0);
        expect(assetPrice.getRealValue(), equals(100.0));
      });

      test('getRealValue() should return null if real value is not present',
          () {
        const assetPrice = AssetPrice.estimated(150.0);
        expect(assetPrice.getRealValue(), isNull);
      });

      test('isReal() should return true if real value exists', () {
        const assetPrice = AssetPrice(100.0);
        expect(assetPrice.isReal(), isTrue);
      });

      test('isReal() should return false if real value is not present', () {
        const assetPrice = AssetPrice.estimated(150.0);
        expect(assetPrice.isReal(), isFalse);
      });

      test('isEstimated() should return true if estimated value exists', () {
        const assetPrice = AssetPrice.estimated(150.0);
        expect(assetPrice.isEstimated(), isTrue);
      });

      test(
          'isEstimated() should return false if estimated value is not present',
          () {
        const assetPrice = AssetPrice(100.0);
        expect(assetPrice.isEstimated(), isFalse);
      });

      test('toString() should return a string representation of the value', () {
        const assetPrice = AssetPrice(100.0);
        expect(assetPrice.toString(), equals('100.0'));
      });

      test('Equality should be based on the value', () {
        const assetPrice1 = AssetPrice(100.0);
        const assetPrice2 = AssetPrice(100.0);
        const assetPrice3 = AssetPrice(150.0);

        expect(assetPrice1, equals(assetPrice2));
        expect(assetPrice1, isNot(equals(assetPrice3)));
      });

      test(
        'hashCode should be based on the value',
        () {
          const assetPrice1 = AssetPrice(100.0);
          const assetPrice2 = AssetPrice(100.0);
          const assetPrice3 = AssetPrice(150.0);

          expect(assetPrice1.hashCode, equals(assetPrice2.hashCode));
          expect(assetPrice1.hashCode, isNot(equals(assetPrice3.hashCode)));
        },
      );
    },
  );
}
