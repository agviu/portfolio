import 'package:flutter/material.dart';

class NewInvestment extends StatefulWidget {
  const NewInvestment({super.key});

  @override
  State<NewInvestment> createState() {
    return _NewInvestmentState();
  }
}

class _NewInvestmentState extends State<NewInvestment> {
  String _enteredCode = "";

  void _saveCodeInput(String code) {
    print(code);
    _enteredCode = code;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: _saveCodeInput,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Investment code'),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(_enteredCode);
                    },
                    child: const Text('Save investment')),
              ],
            )
          ],
        ));
  }
}
