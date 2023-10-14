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
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Investment code'),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print(_titleController.text);
                    },
                    child: const Text('Save investment')),
              ],
            )
          ],
        ));
  }
}
