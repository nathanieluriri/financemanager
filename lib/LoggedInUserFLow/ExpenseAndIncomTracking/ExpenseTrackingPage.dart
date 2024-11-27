import 'package:financemanager/CustomWidgets/BarCharts/ExpenseBarChart.dart';
import 'package:financemanager/CustomWidgets/Builder/ExpenseRankingList.dart';
import 'package:financemanager/CustomWidgets/CategoryPercentages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ReportsAndAnalyticsForExpense extends StatefulWidget {
  final Box userbox;

  const ReportsAndAnalyticsForExpense({super.key, required this.userbox});

  @override
  State<ReportsAndAnalyticsForExpense> createState() =>
      _ReportsAndAnalyticsForExpenseState();
}

class _ReportsAndAnalyticsForExpenseState
    extends State<ReportsAndAnalyticsForExpense> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {},
        child: ListView(
          children: [
            Text("Expense Ranking By Categorization"),
            widget.userbox.get("Categorized Expense List")?.isNotEmpty ?? false
                ?
            RankedExpenseList(userbox: widget.userbox):
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:38.0,vertical: 250),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: const Text("Plan An Expense To See an Analysis"),
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(20),)
                ),
              ),
            ),


            // Text("Expense Visualization"),
            // Expensebarchart(),
          ],
        ),
      ),
    );
  }
}
