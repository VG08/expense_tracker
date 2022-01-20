import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatefulWidget {
  Function onAddTransaction;

  TransactionForm(this.onAddTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: titleController,
                onSubmitted: (_) {
                  amountFocusNode.requestFocus();
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                focusNode: amountFocusNode,
                onSubmitted: (_) {
                  widget.onAddTransaction(
                      titleController.text, amountController.text);
                },
              ),
              FlatButton(
                onPressed: () {
                  widget.onAddTransaction(
                      titleController.text, amountController.text);
                },
                child: const Text(
                  "Add transaction",
                  style: TextStyle(color: Colors.black),
                ),
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
