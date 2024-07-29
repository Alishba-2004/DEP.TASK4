import 'package:flutter/material.dart';

class InsertScreen extends StatelessWidget {
  const InsertScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insert Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/insert-income');
              },
              child: const Text('Insert Income'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/insert-expense');
              },
              child: const Text('Insert Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
