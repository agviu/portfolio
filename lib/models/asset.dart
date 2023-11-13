import 'package:flutter/material.dart';
import 'package:portfolio/models/category.dart';

class AssetPrice {
  const AssetPrice({
    required this.timestamp,
    required this.value,
  });

  final DateTime timestamp;
  final double value;
}

class Asset {
  const Asset({
    required this.code,
    required this.prices,
    this.category = Category.crypto,
  });

  final String code;

  final List<AssetPrice> prices;

  final Category category;
}
