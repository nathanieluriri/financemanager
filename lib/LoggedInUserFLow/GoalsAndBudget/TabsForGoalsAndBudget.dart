import 'dart:async';

import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/PlanAnIncomPage.dart';
import 'package:financemanager/LoggedInUserFLow/BudgetingAndMonitoring/MainBudgetPage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/PlanAnExpensePage.dart';
import 'package:financemanager/LoggedInUserFLow/FinancialGoal/FinancialGoal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MainPageForGoalsAndBudget extends StatefulWidget {
  final VoidCallback moveToReportPage;
  final VoidCallback moveToOverviewPage;
  final Box userBox;
  final VoidCallback setupBudgetButton;
  final VoidCallback setupGoalButton;
  final VoidCallback editGoalButton;

  const MainPageForGoalsAndBudget({
    super.key,
    required this.userBox,
    required this.setupBudgetButton,
    required this.setupGoalButton,
    required this.moveToReportPage,
    required this.moveToOverviewPage,
    required this.editGoalButton,
  });

  @override
  State<MainPageForGoalsAndBudget> createState() =>
      _MainPageForGoalsAndBudgetState();
}

class _MainPageForGoalsAndBudgetState extends State<MainPageForGoalsAndBudget> {
  late Timer _updateTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _updateTimer = Timer.periodic(Duration(seconds: 1), (timer) {
   if(mounted){
     setState(() {

     });
   }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Budgeting And Goal Tools",
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
          bottom: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "Budget",
                ),
                Tab(
                  text: "Goals",
                ),
              ]),
        ),
        body: TabBarView(children: [
          MainBudgetPage(
            setUpNewBudgetButton: widget.setupBudgetButton,
            userBox: widget.userBox,
          ),
          Goalspage(
            userBox: widget.userBox,
            setUpNewGoalButton: widget.setupGoalButton,
            editGoal: widget.editGoalButton,
          ),
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
          currentIndex: 2,
          // Highlight the selected item
          selectedItemColor: Colors.orange.shade200,
          // Color of the selected item
          onTap: (value) {
            if (value == 1) {
              widget.moveToReportPage();
            } else if (value == 0) {
              widget.moveToOverviewPage();
            }
          }, // Handle tab taps
        ),
      ),
    );
  }
}
