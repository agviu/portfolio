import 'package:flutter/material.dart';
import 'package:portfolio/models/category.dart';
import 'package:portfolio/models/investment.dart';
import 'package:portfolio/widgets/investments_list/investments_list.dart';
import 'package:portfolio/widgets/new_investment.dart';
import 'package:portfolio/widgets/chart/chart.dart';

class Investments extends StatefulWidget {
  const Investments({super.key});

  @override
  State<Investments> createState() {
    return _InvestmentsState();
  }
}

class _InvestmentsState extends State<Investments> {
  final List<Investment> _listInvestments = [
    Investment(
        code: 'BTC',
        purchasePrice: 2.22,
        purchaseTime: DateTime.now(),
        currentValue: 2.34),
    Investment(
        code: 'XEM',
        purchasePrice: 1.45,
        purchaseTime: DateTime.now(),
        currentValue: 4.55),
    Investment(
        code: 'DOT',
        purchasePrice: 1.45,
        purchaseTime: DateTime.now(),
        currentValue: 4.55),
    Investment(
        code: 'ELF',
        purchasePrice: 1.45,
        purchaseTime: DateTime.now(),
        currentValue: 4.55),
    Investment(
        code: 'FLO',
        purchasePrice: 1.45,
        purchaseTime: DateTime.now(),
        currentValue: 4.55),
    Investment(
      code: 'NSR',
      purchasePrice: 1.45,
      purchaseTime: DateTime.now(),
      currentValue: 4.55,
      category: Category.stock,
    )
  ];

  void _addInvestment(Investment investment) {
    setState(() {
      _listInvestments.add(investment);
    });
  }

  void _removeInvestment(Investment investment) {
    final investmentIndex = _listInvestments.indexOf(investment);
    setState(() {
      _listInvestments.remove(investment);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Investment deleted'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _listInvestments.insert(investmentIndex, investment);
            });
          },
        ),
      ),
    );
  }

  void _openAddInvestmentOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewInvestment(onAddInvestment: _addInvestment),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No investments found. Add one!"),
    );

    if (_listInvestments.isNotEmpty) {
      mainContent = InvestmentsList(
        investments: _listInvestments,
        onRemoveExpense: _removeInvestment,
      );
    }
    return Column(
      children: [
        Chart(investments: _listInvestments),
        // Text('List of expenses...'),
        Expanded(child: mainContent),
      ],
    );
  }
}
