import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/ExpenseTrackingPage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/IncomeTrackingPage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/PlanAnExpensePage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/PlanAnIncomPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ReportAndAnalyticsPage extends StatefulWidget {
  final VoidCallback moveToOverviewPage;
  final Box userBox;
  final VoidCallback moveToGoalPage;

  const ReportAndAnalyticsPage({
    super.key,
    required this.moveToOverviewPage,
    required this.userBox,
    required this.moveToGoalPage,
  });

  @override
  State<ReportAndAnalyticsPage> createState() => _ReportAndAnalyticsPageState();
}

class _ReportAndAnalyticsPageState extends State<ReportAndAnalyticsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int isSelected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        isSelected = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Report And Visualization",
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(Icons.candlestick_chart),
        bottom: TabBar(
            controller: _tabController,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.bar_chart,
                  color: isSelected == 0 ? Colors.green : Colors.grey,
                ),
                text: "Categorized Income Report",
              ),
              Tab(
                icon: Icon(Icons.bar_chart,
                    color: isSelected == 1 ? Colors.red : Colors.grey),
                text: "Categorized Expense Report",
              ),
            ]),
      ),
        backgroundColor: Colors.white,
      body: TabBarView(controller: _tabController, children: [
        ReportsAndAnalyticsForIncome(userbox: widget.userBox,),
        ReportsAndAnalyticsForExpense(userbox: widget.userBox,),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: 'Goals',
          ),
        ],
        currentIndex: 1,
        // Highlight the selected item
        selectedItemColor: Colors.orange.shade200,
        // Color of the selected item
        onTap: (value) {
          if (value == 0) {
            widget.moveToOverviewPage();
          } else if (value == 2) {
            widget.moveToGoalPage();
          }
        }, // Handle tab taps
      ),
    );
  }
}
