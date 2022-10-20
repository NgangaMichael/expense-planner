import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'transactionitems.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction>transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty ? 
    LayoutBuilder(
      builder: ((context, constraints) {
        return Column(
        children: [
          Text('No transaction added yet!',
          style: Theme.of(context).textTheme.subtitle1,
          ),

          const SizedBox(
            height: 20,
          ),

          Container(
            height: constraints.maxHeight * 0.6,
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          )
        ],
      );
      })  
    )
     : ListView.builder(
        itemBuilder: (ctx, index) {
            return TransactionItems(transactions: transactions[index], deleteTransaction: deleteTransaction);
        },
        itemCount: transactions.length,
        );
  }
}

