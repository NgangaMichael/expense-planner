import 'package:expense_planner/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // late String titleInput;
  // late String amountInput;

  final textController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                color: Colors.blue,
                child: const Text('CHART!'),
              ),
            ),
      
            UserTransactions(),
          ],
        ),
      )
    );
  }
}
