import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  //To seal the app on only portrait mode, no landscape
  // SystemChrome.setP referredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        hintColor: Colors.blueAccent,
        fontFamily: 'OpenSans',
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 25,
          fontWeight: FontWeight.bold,
        )),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _displayExpChart = false;

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 13.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Shirt',
    //   amount: 17.99,
    //   date: DateTime.now(),
    // )
  ];
  List<Transaction> get _recentExpenses {
    return _userTransactions.where((exp) {
      return exp.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewExpenses(exTitle, exAmount, DateTime chosedExpDate) {
    final newExp = Transaction(
      title: exTitle,
      amount: exAmount,
      date: chosedExpDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newExp);
    });
  }

  void _startNewExpenses(BuildContext expense) {
    showModalBottomSheet(
      context: expense,
      builder: (_) {
        return NewTransaction(_addNewExpenses);
      },
    );
  }

  void _deleteExpense(String id) {
    setState(() {
      _userTransactions.removeWhere(
        (exps) => exps.id == id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery= MediaQuery.of(context);
    final landScapeMode= mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: const Text('Expenses_Manager'),
      actions: [
        IconButton(
            onPressed: () => _startNewExpenses(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(landScapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch.adaptive(
                    value: _displayExpChart,
                    onChanged: (chart) {
                      setState(() {
                        _displayExpChart = chart;
                      });
                    },
                  )
                ],
              ),
              if(!landScapeMode)
                Container(
                    height: mediaQuery.size.height * 0.22,
                    child: Chart(_recentExpenses),
                ),
              if(!landScapeMode) TransactionList(_userTransactions, _deleteExpense),

              if(landScapeMode)
              _displayExpChart
                  ? Container(
                height: mediaQuery.size.height * 0.43,
                  child: Chart(_recentExpenses))
                  : TransactionList(_userTransactions, _deleteExpense),
            ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ? const SizedBox() : FloatingActionButton(
        onPressed: () => _startNewExpenses(context),
        child: const Icon(Icons.add),
      ),


      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' My Course '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.notifications),
            //   title: const Text(' Notifications '),
            //   onTap: () {
            //     Navigator.push(context);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),


    );
  }
}
