import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Category { crypto, stock }

const categoryIcons = {
  Category.crypto: Icons.account_balance_wallet,
  Category.stock: Icons.account_balance,
  "something": "something",
  2: "something",
};

class Investment {
  const Investment(
      {required this.code,
      required this.purchasePrice,
      required this.purchaseTime,
      required this.currentValue});

  final String code;

  final double purchasePrice;

  final DateTime purchaseTime;

  final double currentValue;

  String get formattedPurchaseTime {
    return DateFormat.yMd().format(purchaseTime);
  }
}
