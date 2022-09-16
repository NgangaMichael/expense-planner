import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key? key}) : super(key: key);
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitData() {

    final enterdTitle = _textController.text;
    final enterdAmount = double.parse(_amountController.text);

    if(enterdTitle.isEmpty || enterdAmount <= 0) {
      return;
    }

    widget.addTx(
      enterdTitle,
      enterdAmount,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2022), 
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
                  controller: _textController,
                  onSubmitted: (_) => _submitData(),

                    // onChanged: (val) {
                    //   titleInput = val;
                    // },
                  ),
                  TextField(decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  // the underscrore mean i get an argumrnt but i dont use it 
                  onSubmitted: (_) => _submitData(),
                    // onChanged: (val) {
                    //   amountInput = val;
                    // },
                  ),

                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null ? 
                            'No date chosen' : 
                            'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'
                          ),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          onPressed: _presentDatePicker, 
                          child: Text('Chose Date', 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ))
                      ],
                    ),
                  ),
                  RaisedButton(
                    onPressed: _submitData,
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).textTheme.button?.color,
                    child: Text('Add transaction'))
                ],
              ),
            ),
          );
  }
}