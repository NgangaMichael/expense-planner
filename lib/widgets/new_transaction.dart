import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key? key}) : super(key: key);
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final textController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {

    final enterdTitle = textController.text;
    final enterdAmount = double.parse(amountController.text);

    if(enterdTitle.isEmpty || enterdAmount <= 0) {
      return;
    }

    widget.addTx(
      enterdTitle,
      enterdAmount,
    );

    Navigator.of(context).pop();
  }

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
                  onSubmitted: (_) => submitData(),

                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                  ),
                  TextField(decoration: InputDecoration(labelText: 'Amount'),
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  // the underscrore mean i get an argumrnt but i dont use it 
                  onSubmitted: (_) => submitData(),
                    // onChanged: (val) {
                    //   amountInput = val;
                    // },
                  ),
                  FlatButton(
                    onPressed: submitData,
                    textColor: Colors.purple,
                    child: Text('Add transaction'))
                ],
              ),
            ),
          );
  }
}