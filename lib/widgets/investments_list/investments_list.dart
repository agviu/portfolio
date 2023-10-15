import 'package:flutter/material.dart';

import 'package:portfolio/models/investment.dart';
import 'package:portfolio/widgets/investments_list/investment_item.dart';

class InvestmentsList extends StatelessWidget {
  const InvestmentsList(
      {super.key, required this.investments, required this.onRemoveExpense});

  final List<Investment> investments;
  final void Function(Investment investment) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(investments[index]),
        child: InvestmentItem(investments[index]),
        onDismissed: (direction) {
          onRemoveExpense(investments[index]);
        },
      ),
      itemCount: investments.length,
    );
  }
}
