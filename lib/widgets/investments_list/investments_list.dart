import 'package:flutter/material.dart';

import 'package:portfolio/models/investment.dart';
import 'package:portfolio/widgets/investments_list/investment_item.dart';

class InvestmentsList extends StatelessWidget {
  const InvestmentsList({super.key, required this.investments});

  final List<Investment> investments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => InvestmentItem(investments[index]), 
      itemCount: investments.length,
    );
  }
}