import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;
  BarChart(this.label, this.spendingAmount, this.spendingPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        children: [
          Container(
              height: 20,
              child: FittedBox(
                  child: Text("Rs ${spendingAmount.toStringAsFixed(0)}"))),
          SizedBox(height: 4),
          Container(
            height: 120,
            width: 20,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    //border: Border.all(color: Colors.green, width: 1.0),
                    color: Colors.green,
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1 - spendingPctOfTotal,
                  child: Container(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 4),
          Text(label)
        ],
      ),
    );
  }
}
