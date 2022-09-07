import 'package:expense_planner/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  final List<Transaction> transaction = [
    Transaction(id: 't1', title: 'New shoes', amount: 500.34, date: DateTime.now()),
    Transaction(id: 't2', title: 'Phone', amount: 400.4, date: DateTime.now()),
    Transaction(id: 't3', title: 'Food', amount: 350.57, date: DateTime.now()),
  ];

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
      body:Column(
        children: [
          Container(
            width: double.infinity,
            child: const Card(
              color: Colors.blue,
              child: const Text('CHART!'),
            ),
          ),

          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(decoration: InputDecoration(labelText: 'Title'),
                  controller: textController,
                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                  ),
                  TextField(decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                    // onChanged: (val) {
                    //   amountInput = val;
                    // },
                  ),
                  FlatButton(
                    onPressed: () {
                      print(textController.text);
                      print(amountController.text);
                    },
                    textColor: Colors.purple,
                    child: Text('Add transaction'))
                ],
              ),
            ),
          ),

          Column(
            children: transaction.map((tx) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text('\$${tx.amount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.purple,
                        ),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tx.title, 
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMd().format(tx.date),
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList()
          )
        ],
      )
    );
  }
}
