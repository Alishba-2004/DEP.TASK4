import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetManagementScreen extends StatefulWidget {
  const BudgetManagementScreen({super.key});

  @override
  _BudgetManagementScreenState createState() => _BudgetManagementScreenState();
}

class _BudgetManagementScreenState extends State<BudgetManagementScreen> {
  final TextEditingController _budgetController = TextEditingController();
  double _budget = 0.0;
  double _budgetLimit = 1000.0; // Default budget limit

  List<double> _budgetHistory = [];

  void _setBudget() {
    final newBudget = double.tryParse(_budgetController.text);
    if (newBudget != null) {
      if (newBudget > _budgetLimit) {
        _showErrorDialog('Budget exceeds the maximum limit of \$${_budgetLimit.toStringAsFixed(2)}');
        return;
      }

      setState(() {
        _budget = newBudget;
        _budgetHistory.add(newBudget);
      });
      _budgetController.clear();
    }
  }

  void _setBudgetLimit() {
    final limit = double.tryParse(_budgetController.text);
    if (limit != null) {
      setState(() {
        _budgetLimit = limit;
      });
      _budgetController.clear();
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Budget'),
          content: Text('Are you sure you want to set the budget to \$${_budgetController.text}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _setBudget();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Budget'),
        backgroundColor: Colors.blueAccent,
        elevation: 0, // No shadow for a cleaner look
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Manage Your Budget',
                style: GoogleFonts.roboto(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: _budgetController,
                label: 'Enter Budget Amount',
                icon: Icons.attach_money,
                onSubmitted: (value) => _showConfirmationDialog(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showConfirmationDialog,
                child: const Text('Set Budget'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: GoogleFonts.roboto(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              _buildBudgetDisplay('Current Budget', _budget),
              const SizedBox(height: 20),
              _buildBudgetDisplay('Budget Limit', _budgetLimit),
              const SizedBox(height: 20),
              _buildInputField(
                controller: _budgetController,
                label: 'Set Budget Limit',
                icon: Icons.account_balance_wallet,
                onSubmitted: (value) => _setBudgetLimit(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _setBudgetLimit,
                child: const Text('Set Budget Limit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: GoogleFonts.roboto(fontSize: 18),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Budget History:',
                style: GoogleFonts.roboto(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _budgetHistory.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        title: Text(
                          'Budget ${index + 1}: \$${_budgetHistory[index].toStringAsFixed(2)}',
                          style: GoogleFonts.roboto(color: Colors.black87),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required void Function(String) onSubmitted,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      keyboardType: TextInputType.number,
      style: GoogleFonts.roboto(fontSize: 18),
      onSubmitted: onSubmitted,
    );
  }

  Widget _buildBudgetDisplay(String title, double amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
