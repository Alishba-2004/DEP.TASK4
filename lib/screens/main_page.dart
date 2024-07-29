import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'history_screen.dart';
import 'update_screen.dart';

class MainPage extends StatefulWidget {
  final double totalIncome;
  final double totalExpense;
  final void Function(double) updateIncome;
  final void Function(double, String) updateExpense;

  const MainPage({
    Key? key,
    required this.totalIncome,
    required this.totalExpense,
    required this.updateIncome,
    required this.updateExpense,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      HomeScreen(
        updateIncome: widget.updateIncome,
        updateExpense: widget.updateExpense,
      ),
      const HistoryScreen(),
      UpdateScreen(
        updateIncome: widget.updateIncome,
        updateExpense: widget.updateExpense,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Update',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
