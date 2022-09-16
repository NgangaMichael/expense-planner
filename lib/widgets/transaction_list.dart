import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction>transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty ? Column(
        children: [
          Text('No transaction added yet!',
          style: Theme.of(context).textTheme.subtitle1,
          ),

          SizedBox(
            height: 20,
          ),

          Container(
            height: 200,
            child: Image.asset('assets/images/waiting.png',
            fit: BoxFit.cover,
            ),
          )
        ],
      ) : ListView.builder(
        itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 5
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox
                    (
                      child: Text('\$${transactions[index].amount}')
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
            
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date)
                ),
              ),
            );
        },
        itemCount: transactions.length,
        )
      );
  }
}