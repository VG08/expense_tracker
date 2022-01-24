import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/bar_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double amount = 0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          amount = amount + recentTransactions[i].amount;
        }
      }
      //print(DateFormat.E().format(weekDay));
      return {
        "day": DateFormat.E().format(weekDay),
        "amount": amount,
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValue.fold(0.0, (previousValue, item) {
      //print("dfsd" + (previousValue + item["amount"]).toString());
      return previousValue + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValue);
    return Container(
      //width: double.infinity,
      child: Card(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValue.map((data) {
              return BarChart(data["day"], data["amount"],
                  maxSpending != 0.0 ? data["amount"] / maxSpending : 0);
            }).toList()),
        margin: EdgeInsets.all(15),
      ),
    );
  }
}
