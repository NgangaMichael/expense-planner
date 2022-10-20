import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';


class TransactionItems extends StatelessWidget {
  const TransactionItems({
    Key? key,
    required this.transactions,
    required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
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
              child: Text('\$${transactions.amount}')
            ),
          ),
        ),
        title: Text(
          transactions.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
    
        subtitle: Text(
          DateFormat.yMMMd().format(transactions.date)
        ),
        trailing: MediaQuery.of(context).size.width > 630 
        ?
        FlatButton.icon(
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
          textColor: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transactions.id),
        ) :                
        IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransaction(transactions.id),
        ),
      ),
    );
  }
}