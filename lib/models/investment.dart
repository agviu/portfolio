import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Category { crypto, stock }

final dateFormatter = DateFormat.yMd();

const categoryIcons = {
  Category.crypto: Icons.account_balance_wallet,
  Category.stock: Icons.account_balance,
};

class Investment {
  const Investment(
      {required this.code,
      required this.purchasePrice,
      required this.purchaseTime,
      required this.currentValue,
      this.category = Category.crypto});

  final String code;

  final double purchasePrice;

  final DateTime purchaseTime;

  final double currentValue;

  final Category category;

  String get formattedPurchaseTime {
    return dateFormatter.format(purchaseTime);
  }
}

class InvestmentBucket {
  InvestmentBucket.forCategory(List<Investment> allInvestments, this.category)
      : investments = allInvestments
            .where((investment) => investment.category == category)
            .toList();

  final Category category;
  final List<Investment> investments;

  double get totalInvestments {
    double sum = 0;

    for (final investment in investments) {
      sum += investment.currentValue;
    }

    return sum;
  }
}
