import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Ensure you have this import for GoogleFonts
import 'screens/insert_income_screen.dart';
import 'screens/insert_expense_screen.dart';
import 'screens/expense_summary_screen.dart';
import 'screens/budget_management_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/insert_option_screen.dart';
import 'screens/home_screen.dart';
import 'screens/main_page.dart'; // Import MainPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _totalIncome = 0.0;
  double _totalExpense = 0.0;
  final List<Map<String, dynamic>> _expenses = [];
  bool _isDarkTheme = false;

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkTheme = isDark;
    });
  }

  void _saveIncome(double amount) {
    setState(() {
      _totalIncome += amount;
    });
  }

  void _saveExpense(double amount, String category) {
    setState(() {
      _totalExpense += amount;
      _expenses.add({'category': category, 'amount': amount, 'date': DateTime.now()});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: _isDarkTheme ? ThemeData.dark() : ThemeData.light(),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => MainPage(
          totalIncome: _totalIncome,
          totalExpense: _totalExpense,
          updateIncome: _saveIncome,
          updateExpense: _saveExpense,
        ),
        '/insert-income': (context) => InsertIncomeScreen(
          onSave: (amount, date) {
            Navigator.pop(context, amount);
            _saveIncome(amount);
          },
        ),
        '/insert-expense': (context) => InsertExpenseScreen(
          onSave: (amount, category, date) {
            Navigator.pop(context, [amount, category, date]);
            _saveExpense(amount, category);
          },
        ),
        '/expense-summary': (context) => ExpenseSummaryScreen(
          totalIncome: _totalIncome,
          totalExpense: _totalExpense,
          expenses: _expenses,
        ),
        '/budget-management': (context) => BudgetManagementScreen(),
        '/settings': (context) => SettingsScreen(onThemeChanged: _toggleTheme),
      },
    );
  }
}
