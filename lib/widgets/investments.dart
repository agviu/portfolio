import 'package:flutter/material.dart';
import 'package:portfolio/models/investment.dart';
import 'package:portfolio/widgets/investments_list/investments_list.dart';

class Investments extends StatefulWidget {
  const Investments({super.key});

  @override
  State<Investments> createState() {
    return _InvestmentsState();
  }
}

class _InvestmentsState extends State<Investments> {

  final List<Investment> _listInvestments = [
    Investment(code: 'BTC', purchasePrice: 2.22, purchaseTime: DateTime.now(), currentValue: 2.34),
    Investment(code: 'XEM', purchasePrice: 1.45, purchaseTime: DateTime.now(), currentValue: 4.55),
    Investment(code: 'DOT', purchasePrice: 1.45, purchaseTime: DateTime.now(), currentValue: 4.55),
    Investment(code: 'ELF', purchasePrice: 1.45, purchaseTime: DateTime.now(), currentValue: 4.55),
    Investment(code: 'FLO', purchasePrice: 1.45, purchaseTime: DateTime.now(), currentValue: 4.55),
    Investment(code: 'NSR', purchasePrice: 1.45, purchaseTime: DateTime.now(), currentValue: 4.55),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          const Text('The investments...'),
          // Text('List of expenses...'),
          Expanded( child: InvestmentsList(investments: _listInvestments)),
        ],)
    );
  }
}