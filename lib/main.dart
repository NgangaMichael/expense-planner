import 'dart:ffi';
import 'dart:ui';
// .io is for IOS look 
import 'dart:io';

// cupertino is for loading IOS scafold while matrial is for android 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

import 'models/transaction.dart';
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown
  //   ]
  // );
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // if platform is IOS is will return IOS app else will be android the code is commented coz it has errors 
    return 
    // Platform.isIOS ? CupertinoApp(
    //   title: 'Personal Expenses',
    //   theme: CupertinoThemeData(
    //     primarySwatch: Colors.purple,
    //     accentColor: Colors.amber,
    //     fontFamily: 'Quicksand',
        
    //     textTheme :ThemeData.light().textTheme.copyWith(
    //         subtitle1: TextStyle(
    //           fontFamily: 'OpenSans',
    //           fontSize: 18,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         button: TextStyle(color: Colors.white)
    //       ),

    //       appBarTheme: AppBarTheme(
    //         titleTextStyle: TextStyle(
    //           fontFamily: 'OpenSans',
    //           fontSize: 20,
    //           fontWeight: FontWeight.bold
    //         )
    //       )
        
    //   ),
    //   home: MyHomePage(),
    // )
    // : 
    MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        
        textTheme :ThemeData.light().textTheme.copyWith(
            subtitle1: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white)
          ),

          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'New shoes', amount: 500.34, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Phone', amount: 400.4, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Food', amount: 350.57, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        )
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final newTx = Transaction(
      id: DateTime.now().toString(), 
      title: txTitle, 
      amount: txAmount, 
      date: chosenDate,
    );

      setState(() {
        _userTransactions.add(newTx);
      });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return GestureDetector(
        onTap: () {},
        child: NewTransaction(_addNewTransaction),
        behavior: HitTestBehavior.opaque,
      );
    },);
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // stooring media query ina avariable for reusage 
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    
    final  dynamic appbar = Platform.isIOS ? 
    CupertinoNavigationBar(
      middle: const Text(
        'Personal Expenses'
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add)
          )
        ],
      ),
    ) 
    
    : AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context), 
            icon: Icon(Icons.add)
          )
        ],
      );

      final textWidget = Container(
        height: (mediaquery.size.height - appbar.preferredSize.height
        - mediaquery.padding.top) * 0.7,
        child: TransactionList(_userTransactions, _deleteTransaction)
      );

      // safe area widget is for respection areas that cant be coverd by the app 
      final pageBody = SafeArea(
        child: SingleChildScrollView(
        child: Column(
          children: [
            // special if that doesnt need {()} 
            if(isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Show chart'),
                // you add .adaptive to have IOS look and android look separatly on one code 
                Switch.adaptive(value: _showChart, 
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                }
                ),
              ],
            ),

            if(!isLandscape)
            Container(
              height: (mediaquery.size.height - appbar.preferredSize.height
              - mediaquery.padding.top) * 0.3,
              child: Chart(_recentTransaction)
            ),

            if(!isLandscape) textWidget,

            if(isLandscape)
            _showChart ? Container(
              height: (mediaquery.size.height - appbar.preferredSize.height
              - mediaquery.padding.top) * 0.6,
              child: Chart(_recentTransaction)
            )
            : textWidget
          ],
        ),
      ));

    return Platform.isIOS ? CupertinoPageScaffold(
      navigationBar: appbar,
      child: pageBody,
    ) 
    
    : Scaffold(
      appBar: appbar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // if its IOS then dont show the button 
      floatingActionButton: Platform.isIOS ? Container()
      :
       FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add), 
      ),
    );
  }
}