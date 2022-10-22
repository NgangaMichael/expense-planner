import 'dart:io';

import 'package:expense_planner/widgets/addaptiveBUttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({Key? key}) : super(key: key);
  final Function addTx;

  NewTransaction(this.addTx){
    print('contructor new transaction widget');
  }

  @override
  State<NewTransaction> createState() {
    print('create state new transaction widget');
    return  _NewTransactionState();
  } 

}

class _NewTransactionState extends State<NewTransaction> {
  final _textController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _NewTransactionState() {
    print('constaractor new transaction state');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initstate()');

  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didupdatewidget()');

  }

  @override
  void dispose() {
    super.dispose();
    print('dispose()');
  }

  void _submitData() {
    if(_amountController.text.isEmpty) {
      return;
    }
    final enterdTitle = _textController.text;
    final enterdAmount = double.parse(_amountController.text);

    if(enterdTitle.isEmpty || enterdAmount <= 0 || _selectedDate == null) {
      return;
    }

  // adding transaction wich is passed to main dart 
    widget.addTx(
      enterdTitle,
      enterdAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    Future.delayed(Duration.zero,(){
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
                        // this is imported from addaptive buttons then we run it here for clean code 
                        AddaptiveButtons('Choose date', _presentDatePicker)
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