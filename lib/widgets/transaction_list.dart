import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 50 / 100,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2)),
                  child: Text(
                    "Rs ${transactions[index].amount.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactions[index].title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(DateFormat("yMMMMd").format(transactions[index].date),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
