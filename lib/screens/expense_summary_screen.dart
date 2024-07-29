import 'package:flutter/material.dart';

// Define a color map for categories
const Map<String, Color> categoryColors = {
  'Food': Colors.orange,
  'Transport': Colors.blue,
  'Utilities': Colors.green,
  'Entertainment': Colors.purple,
  'Health': Colors.red,
  'Others': Colors.grey,
};

class ExpenseSummaryScreen extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final List<Map<String, dynamic>> expenses;

  const ExpenseSummaryScreen({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
    required this.expenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Summary'),
        backgroundColor: Colors.blueAccent,
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center all column content
          children: [
            Text(
              'Total Income: \$${totalIncome.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Expenses:',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  final category = expense['category'];
                  final color = categoryColors[category] ?? Colors.grey;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      tileColor: color.withOpacity(0.2), // Light color background
                      title: Text(
                        category,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      subtitle: Text(
                        'Amount: \$${expense['amount'].toStringAsFixed(2)}\nDate: ${expense['date'].toString().split(' ')[0]}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
