import 'package:flutter/material.dart';
import 'package:portfolio/models/investment.dart';

class InvestmentItem extends StatelessWidget {
  const InvestmentItem(this.investment, {super.key});

  final Investment investment;

  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(
        children: [
          Text(investment.code),
          const SizedBox(height: 4,),
          Row(children: [
            Column(
              children: [
                const Text('Purchase time'),
                Text(investment.formattedPurchaseTime),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Text('Purchase price'),
                Text(investment.purchasePrice.toString()),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Text('Current value'),
                Text(investment.currentValue.toString()),
              ],
            ),
          ],)
      ],)
    ),
    );
  }
}