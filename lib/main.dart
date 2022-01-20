// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//package imports

import 'package:expense_tracker/widgets/transaction_form.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
//local file imoprts
import 'widgets/chart.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  final titleFocusNode = FocusNode();

  void openAddTransactionForm(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return TransactionForm(onAddTransaction);
        });
  }

  final List<Transaction> transactions = [
    Transaction(1, "Shoes", 1650, DateTime.now()),
    Transaction(2, "Mug", 785, DateTime.now()),
  ];

  void onAddTransaction(String titleInput, String amountInput) {
    print(amountInput);
    double amount = double.parse(amountInput);

    if (titleInput.isEmpty || amount < 0) {
      print("here");
      return;
    }
    setState(() {
      transactions.add(
        Transaction(
          transactions.length + 1,
          titleInput,
          amount,
          DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: () => openAddTransactionForm(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chart(),
            TransactionList(transactions),
            TransactionForm(onAddTransaction)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddTransactionForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
