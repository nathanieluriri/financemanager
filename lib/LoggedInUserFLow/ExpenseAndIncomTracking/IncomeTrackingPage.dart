import 'package:financemanager/CustomWidgets/BarCharts/IncomeBarChart.dart';
import 'package:financemanager/CustomWidgets/Builder/IncomeRankingList.dart';
import 'package:financemanager/CustomWidgets/CategoryPercentages.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ReportsAndAnalyticsForIncome extends StatefulWidget {
  final Box userbox;

  const ReportsAndAnalyticsForIncome({super.key, required this.userbox});

  @override
  State<ReportsAndAnalyticsForIncome> createState() =>
      _ReportsAndAnalyticsForIncomeState();
}

class _ReportsAndAnalyticsForIncomeState
    extends State<ReportsAndAnalyticsForIncome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {},
        child: ListView(
          children: [
            Text("Income Ranking By Categorization"),
            widget.userbox.get("Categorized Income List")?.isNotEmpty ?? false
                ? RankedIncomeList(userbox: widget.userbox)
                :  Padding(
              padding: const EdgeInsets.symmetric(horizontal:38.0,vertical: 250),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: const Text("Plan An Income To See an Analysis"),
                ),
                decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.all(Radius.circular(20),)
                ),
              ),
            ),

            // Text("Income Visualization"),
            // Incomebarchart(),
          ],
        ),
      ),
    );
  }
}
