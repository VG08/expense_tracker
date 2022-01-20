import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  Function onAddTransaction;
  var amountFocusNode = FocusNode();
  TransactionForm(this.onAddTransaction);

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
                  onAddTransaction(titleController.text, amountController.text);
                },
              ),
              FlatButton(
                onPressed: () {
                  onAddTransaction(titleController.text, amountController.text);
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
