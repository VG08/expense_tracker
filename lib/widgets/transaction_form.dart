import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  Function onAddTransaction;

  TransactionForm(this.onAddTransaction);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime enteredDate = DateTime.now();

  var amountFocusNode = FocusNode();

  void presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        enteredDate = value;
      }
    });
  }

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
                onSubmitted: (_) => presentDatePicker(),
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.grey[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMd().format(enteredDate),
                        style: TextStyle(fontSize: 24),
                      ),
                      FlatButton(
                          color: Colors.lightGreen,
                          onPressed: presentDatePicker,
                          child: Text(
                            "Choose date",
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  widget.onAddTransaction(
                      titleController.text, amountController.text, enteredDate);
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    "Add transaction",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                color: Colors.green[700],
              )
            ],
          ),
        ));
  }
}
