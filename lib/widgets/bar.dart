import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 150.0;
  List<Color> colors = [];

  Bar({this.label, this.amountSpent, this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    if (amountSpent < 40.0) {
      colors = [Colors.green, Colors.green, Colors.green];
    } else if (amountSpent < 80) {
      colors = [Colors.green, Colors.orange, Colors.orange];
    } else {
      colors = [Colors.green, Colors.orange, Colors.red];
    }
    return Column(
      children: <Widget>[
        Text(
          "${amountSpent.toStringAsFixed(2)} ₺",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Container(
          width: 15.0,
          height: barHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 0.4, 0.8])),
        ),
        Text("$label"),
      ],
    );
  }
}
