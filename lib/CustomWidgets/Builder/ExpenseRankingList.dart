import 'package:financemanager/CustomWidgets/Builder/ColumnBuilder.dart';
import 'package:financemanager/CustomWidgets/CategoryPercentages.dart';
import 'package:financemanager/CustomWidgets/GoalTrackingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class RankedExpenseList extends StatefulWidget {
  final Box userbox;

  const RankedExpenseList({super.key, required this.userbox});

  @override
  State<RankedExpenseList> createState() => _RankedExpenseListState();
}

class _RankedExpenseListState extends State<RankedExpenseList> {
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: widget.userbox.get("Categorized Expense List").length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Categorypercentages(
                isIncome: false,
                totalSpentOnCategory: widget.userbox
                    .get("Categorized Expense List")[index]['total'],
                categoryName: widget.userbox
                    .get("Categorized Expense List")[index]['category_name'],
                categoryPercentage: widget.userbox
                    .get("Categorized Expense List")[index]['percentage'],
              ),
              SizedBox(
                height: 12,
              )
            ],
          );
        });
  }
}
