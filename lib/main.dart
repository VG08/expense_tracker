// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//package imports

import 'package:expense_tracker/boxes.dart';
import 'package:expense_tracker/widgets/transaction_form.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//local file imoprts
import 'widgets/chart.dart';
import 'models/transaction.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>("transactions");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: "QuickSand"),
      //theme: ThemeData(primaryColor: Colors.blue, brightness: Brightness.dark),
      title: 'Flutter App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Transaction> get recentTransactions {
    return transactions
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  @override
  void dispose() {
    Hive.close();

    super.dispose();
  }

  final titleFocusNode = FocusNode();

  void openAddTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionForm(onAddTransaction);
        });
  }

  final List<Transaction> transactions = [];

  void onAddTransaction(String titleInput, String amountInput, DateTime date) {
    //print(amountInput);
    double amount = double.parse(amountInput);

    if (titleInput.isEmpty || amount < 0) {
      //print("here");
      return;
    }
    setState(() {
      final box = Boxes.getTransactions();
      box.add(Transaction(
        transactions.length + 1,
        titleInput,
        amount,
        date,
      ));
    });
  }

  void onDeleteTransaction(int index) {
    setState(() {
      transactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () => openAddTransactionForm(context),
              icon: Icon(Icons.settings))
        ],
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            child: Chart(recentTransactions),
            alignment: Alignment.bottomCenter,
          ),
          (transactions.isEmpty) // ternary expression
              ? Column(
                  children: [
                    SizedBox(
                      height: 0.1 * _height,
                    ),
                    Image.asset(
                      "assets/images/waiting.png",
                      width: 0.2 * _width,
                    ),
                    SizedBox(
                      height: 0.01 * _height,
                    ),
                    Text(
                      "No transactions registered yet",
                      style: TextStyle(
                        fontSize: 19.13,
                        fontFamily: "QuickSand",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : ValueListenableBuilder<Box<Transaction>>(
                  valueListenable: Boxes.getTransactions().listenable(),
                  builder: (content, box, _) {
                    final transactions = box.values.toList().cast();
                    return TransactionList(
                        transactions as List<Transaction>, onDeleteTransaction);
                  })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddTransactionForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
