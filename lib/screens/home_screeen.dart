import 'package:budget_ui_flutter/data/data.dart';
import 'package:budget_ui_flutter/models/category.dart';
import 'package:budget_ui_flutter/widgets/bar_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildCategory(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(category: category)));
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.grey, offset: Offset.zero, blurRadius: 6.0)
        ]),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  category.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                Text(
                  "${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)}₺/${category.maxAmount}₺",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17.0),
                )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            LayoutBuilder(builder: (context, constraint) {
              final double maxBarWidth = constraint.maxWidth;
              final double percent =
                  (category.maxAmount - totalAmountSpent) / category.maxAmount;
              double barWidth = (maxBarWidth * percent);

              Color color;

              if (percent >= 0.50)
                color = Theme.of(context).primaryColor;
              else if (percent >= 0.25)
                color = Colors.orange;
              else
                color = Colors.red;

              if (barWidth < 0) barWidth = 0;

              return Container(
                alignment: Alignment.centerLeft,
                height: 20.0,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                    width: barWidth,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              );
            })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text("Simple Budget"),
          ),
          expandedHeight: 100.0,
          forceElevated: true,
          floating: true,
          pinned: false,
          snap: false,
        ),
        SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
          if (index == 0) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      offset: Offset(0.0, 0.0))
                ],
                color: Colors.white,
              ),
              margin: EdgeInsets.all(10.0),
              child: BarChart(
                expenses: weeklySpending,
              ),
            );
          } else {
            final Category category = categories[index - 1];
            double totalAmountSpent = 0;
            category.expenses.forEach((expenses) {
              totalAmountSpent += expenses.cost;
            });
            return _buildCategory(category, totalAmountSpent);
          }
        }, childCount: 1 + categories.length))
      ],
    ));
  }
}
