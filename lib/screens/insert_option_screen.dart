import 'package:flutter/material.dart';

class InsertOptionScreen extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final void Function(double) updateIncome;
  final void Function(double, String) updateExpense;

  const InsertOptionScreen({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
    required this.updateIncome,
    required this.updateExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Removed the title by setting it to an empty Container
        title: Container(),
        backgroundColor: Colors.blueAccent,
        elevation: 0, // Remove shadow for a cleaner look
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Add a bold label above the card
            Text(
              'Log Income & Expenditures',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0), // Space between the label and the card

            // Display income and expense with a card
            Card(
              margin: const EdgeInsets.symmetric(vertical: 18.0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Total Income: \$${totalIncome.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Total Expense: \$${totalExpense.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Buttons in a column for vertical alignment
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40, // Increased height for better usability
                  width: double.infinity, // Use full width
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.pushNamed(context, '/insert-income');
                      if (result != null) {
                        updateIncome(result as double);
                      }
                    },
                    child: const Text('Insert Income'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16), // Padding
                      textStyle: const TextStyle(fontSize: 30), // Larger font size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      side: const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 25), // Space between buttons
                SizedBox(
                  height: 40, // Increased height for better usability
                  width: double.infinity, // Use full width
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.pushNamed(context, '/insert-expense');
                      if (result != null) {
                        final List<dynamic> data = result as List<dynamic>;
                        updateExpense(data[0] as double, data[1] as String);
                      }
                    },
                    child: const Text('Insert Expense'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16), // Padding
                      textStyle: const TextStyle(fontSize: 25), // Larger font size
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      side: const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Floating action button for quick access
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.home),
        tooltip: 'Go to Home',
      ),
    );
  }
}
