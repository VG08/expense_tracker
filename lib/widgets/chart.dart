import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Text(
          "CHART",
          style: TextStyle(fontSize: 40),
        ),
        elevation: 50,
        color: Colors.blue,
      ),
    );
  }
}
