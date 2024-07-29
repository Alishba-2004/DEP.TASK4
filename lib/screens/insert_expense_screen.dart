import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InsertExpenseScreen extends StatefulWidget {
  final void Function(double, String, DateTime) onSave;

  const InsertExpenseScreen({Key? key, required this.onSave}) : super(key: key);

  @override
  _InsertExpenseScreenState createState() => _InsertExpenseScreenState();
}

class _InsertExpenseScreenState extends State<InsertExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  String? _selectedCategory;
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Expense'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Enter Your Expense',
                      style: GoogleFonts.roboto(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expense Amount',
                        prefixIcon: const Icon(Icons.money_off),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.roboto(fontSize: 18),
                    ),
                    const SizedBox(height: 20.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Category',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      items: <String>[
                        'Food',
                        'Transport',
                        'Utilities',
                        'Rent',
                        'Entertainment',
                        'Healthcare',
                        'Education',
                        'Shopping',
                        'Travel',
                        'Other'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      value: _selectedCategory,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        final amount = double.tryParse(_amountController.text);
                        if (amount != null && _selectedCategory != null && _selectedDate != null) {
                          widget.onSave(amount, _selectedCategory!, _selectedDate!);
                          Navigator.pushReplacementNamed(context, '/insert-options');
                        } else {
                          _showErrorDialog(context, 'Please fill in all fields correctly.');
                        }
                      },
                      child: const Text('Save Expense'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        textStyle: GoogleFonts.roboto(fontSize: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
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
}
