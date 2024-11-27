import 'package:financemanager/CustomWidgets/Builder/ColumnBuilder.dart';
import 'package:financemanager/CustomWidgets/CategoryPercentages.dart';
import 'package:financemanager/CustomWidgets/GoalTrackingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class RankedIncomeList extends StatefulWidget {
  final Box userbox;

  const RankedIncomeList({super.key, required this.userbox});

  @override
  State<RankedIncomeList> createState() => _RankedIncomeListState();
}

class _RankedIncomeListState extends State<RankedIncomeList> {
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: widget.userbox.get("Categorized Income List").length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Categorypercentages(
                isIncome: true,
                totalSpentOnCategory: widget.userbox
                    .get("Categorized Income List")[index]['total'],
                categoryName: widget.userbox
                    .get("Categorized Income List")[index]['category_name'],
                categoryPercentage: widget.userbox
                    .get("Categorized Income List")[index]['percentage'],
              ),
              SizedBox(
                height: 12,
              )
            ],
          );
        });
  }
}
