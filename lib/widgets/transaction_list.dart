import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

          SizedBox(
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
                trailing: MediaQuery.of(context).size.width > 630 
                ?
                FlatButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  textColor: Theme.of(context).errorColor,
                  onPressed: () => deleteTransaction(transactions[index].id),
                ) :                
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () => deleteTransaction(transactions[index].id),
                ),
              ),
            );
        },
        itemCount: transactions.length,
        );
  }
}