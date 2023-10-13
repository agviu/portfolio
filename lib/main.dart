import 'package:flutter/material.dart';
import 'package:portfolio/widgets/investments.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investrends portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const DashboardPage(title: 'Portfolio dashboard@1'),
      home: const Investments(),
    );
  }
}

