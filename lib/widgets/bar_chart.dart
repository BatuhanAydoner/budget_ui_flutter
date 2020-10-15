import 'package:budget_ui_flutter/data/data.dart';
import 'package:flutter/material.dart';

import 'bar.dart';

class BarChart extends StatelessWidget {
  List<double> expenses;

  BarChart({this.expenses});

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;
    expenses.forEach((price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });

    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            "Weekly Spending",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
              Text(
                "Sep 12, 2020 - Sep 19, 2020",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(daysOfWeek.length, (index) {
              return Bar(
                  label: daysOfWeek[index],
                  amountSpent: expenses[index],
                  mostExpensive: mostExpensive);
            }),
          ),
        ],
      ),
    );
  }
}
