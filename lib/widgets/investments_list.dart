import 'package:flutter/material.dart';

import 'package:portfolio/models/investment.dart';

class InvestmentsList extends StatelessWidget {
  const InvestmentsList({super.key, required this.investments});

  final List<Investment> investments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Text(investments[index].code), 
      itemCount: investments.length,
    );
  }
}