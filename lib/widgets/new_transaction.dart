import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  // const NewTransaction({Key? key}) : super(key: key);
  final Function addTx;
  final textController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                      addTx(
                        textController.text, 
                        double.parse(amountController.text));
                      // print(textController.text);
                      // print(amountController.text);
                    },
                    textColor: Colors.purple,
                    child: Text('Add transaction'))
                ],
              ),
            ),
          );
  }
}