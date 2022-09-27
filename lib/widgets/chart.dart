import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        if(recentTransaction[i].date.day == weekday.day &&
           recentTransaction[i].date.month == weekday.month &&
           recentTransaction[i].date.year == weekday.year
        ) {
          totalSum += recentTransaction[i].amount;
        }
      }


      // print(DateFormat.E().format(weekday));
      // print(totalSum);

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1), 
        'amount': totalSum
      };
    }
    ).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
        return sum + (item['amount'] as double);
      });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  data['day'] as dynamic, 
                  data['amount'] as dynamic, 
                  totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending
                  ),
              );
              // return Text('${data['day']}: ${data['amount']}');
            }).toList()
          ),
      ),
    );
  }
}