import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final void Function(double) updateIncome;
  final void Function(double, String) updateExpense;

  const UpdateScreen({
    Key? key,
    required this.updateIncome,
    required this.updateExpense,
  }) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _incomeController = TextEditingController();
  final _expenseController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submitIncome() {
    final income = double.tryParse(_incomeController.text);
    if (income != null) {
      widget.updateIncome(income);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Income updated successfully!')),
      );
      _incomeController.clear();
    }
  }

  void _submitExpense() {
    final expense = double.tryParse(_expenseController.text);
    final description = _descriptionController.text;
    if (expense != null && description.isNotEmpty) {
      widget.updateExpense(expense, description);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense updated successfully!')),
      );
      _expenseController.clear();
      _descriptionController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Income Update Section
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Update Income',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _incomeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Income Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submitIncome,
                      child: const Text('Update Income'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Updated parameter
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Expense Update Section
            Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Update Expense',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _expenseController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Expense Amount',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Expense Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _submitExpense,
                      child: const Text('Update Expense'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, // Updated parameter
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
