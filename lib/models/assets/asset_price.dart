import 'package:portfolio/models/time_mode.dart';

class AssetPrice {
  const AssetPrice(this.realValue, {this.mode = TimeMode.yearWeek})
      : estimatedValue = null;

  const AssetPrice.estimated(this.estimatedValue,
      {this.mode = TimeMode.yearWeek})
      : realValue = null;

  final double? realValue;
  final double? estimatedValue;
  final TimeMode mode;

  double getValue() {
    if (isReal()) {
      return realValue!;
    }
    if (isEstimated()) {
      return estimatedValue!;
    } else {
      throw StateError(
          "The asset price did not contain a real neither an estimated value.");
    }
  }

  double? getRealValue() {
    return realValue;
  }

  bool isReal() {
    return realValue != null && estimatedValue == null;
  }

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
