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
            subtitle1: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            button: const TextStyle(color: Colors.white)
          ),

          appBarTheme: const AppBarTheme(
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

// added a mixinn 
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: 'New shoes', amount: 500.34, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Phone', amount: 400.4, date: DateTime.now()),
    // Transaction(id: 't3', title: 'Food', amount: 350.57, date: DateTime.now()),
  ];

  bool _showChart = false;

  @override
  void initState() {
    // this line tells flutter that whenevre app cycle changes take didchange..and bind it here 
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  // added mixin method override 
  // method will be called whenever lifecycle changes 
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
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

  Widget _buildAppBar() {
    return Platform.isIOS ? 
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
  }

  List<Widget> _buildLandScapeContent(
    MediaQueryData mediaquery, 
    AppBar appbar,
    Widget textWidget
  ){
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Show chart'),
        // you add .adaptive to have IOS look and android look separatly on one code 
        Switch.adaptive(value: _showChart, 
        onChanged: (val) {
          setState(() {
            _showChart = val;
          });
        }
        ),
      ],
    ), _showChart ? Container(
      height: (mediaquery.size.height - appbar.preferredSize.height
      - mediaquery.padding.top) * 0.6,
      child: Chart(_recentTransaction)
    )
    : textWidget
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaquery, 
    AppBar appbar,
    Widget textWidget
    ){
    return [Container(
      height: (mediaquery.size.height - appbar.preferredSize.height
      - mediaquery.padding.top) * 0.3,
      child: Chart(_recentTransaction)
    ), textWidget];
  }

  @override
  Widget build(BuildContext context) {
    // stooring media query ina avariable for reusage 
    final mediaquery = MediaQuery.of(context);
    final isLandscape = mediaquery.orientation == Orientation.landscape;
    final  dynamic appbar = _buildAppBar();

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
            if(isLandscape) ..._buildLandScapeContent(
              mediaquery, 
              appbar, 
              textWidget
            ),

            if(!isLandscape) ..._buildPortraitContent(
              mediaquery, 
              appbar, 
              textWidget
            ),
            
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