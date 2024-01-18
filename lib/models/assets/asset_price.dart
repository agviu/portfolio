/// Represents the price of an asset, which can be either real or estimated.
class AssetPrice {
  /// Constructor for a real asset price.
  const AssetPrice(this.realValue) : estimatedValue = null;

  /// Constructor for an estimated asset price.
  const AssetPrice.estimated(this.estimatedValue) : realValue = null;

  /// The real value of the asset price, can be null if it's estimated.
  final double? realValue;

  /// The estimated value of the asset price, can be null if it's real.
  final double? estimatedValue;

  /// Get the value of the asset price, either real or estimated.
  ///
  /// Throws a [StateError] if the asset price contains neither real nor estimated value.
  double getValue() {
    if (isReal()) {
      return realValue!;
    }
    if (isEstimated()) {
      return estimatedValue!;
    } else {
      throw StateError(
          "The asset price did not contain a real nor an estimated value.");
    }
  }

  /// Get the real value of the asset price.
  double? getRealValue() {
    return realValue;
  }

  /// Check if the asset price is real (contains a real value).
  bool isReal() {
    return realValue != null && estimatedValue == null;
  }

  /// Check if the asset price is estimated (contains an estimated value).
  bool isEstimated() {
    return estimatedValue != null && realValue == null;
  }

  @override
  String toString() {
    return getValue().toString();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetPrice &&
          runtimeType == other.runtimeType &&
          getValue() == other.getValue();

  @override
  int get hashCode => getValue().hashCode;
}
