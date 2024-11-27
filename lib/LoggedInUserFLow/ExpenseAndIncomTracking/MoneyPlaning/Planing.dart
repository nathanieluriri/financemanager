import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/PlanAnExpensePage.dart';
import 'package:financemanager/LoggedInUserFLow/ExpenseAndIncomTracking/PlanAnIncomPage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class MoneyplanningPage extends StatefulWidget {
  final VoidCallback backButton;
  final Box userBox;
  final VoidCallback incomePlanButton;
  final VoidCallback expensePlanButton;

  const MoneyplanningPage(
      {super.key,
      required this.backButton,
      required this.userBox,
      required this.incomePlanButton,
      required this.expensePlanButton});

  @override
  State<MoneyplanningPage> createState() => _MoneyplanningPageState();
}

class _MoneyplanningPageState extends State<MoneyplanningPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int isSelected = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener((){

      setState(() {
        isSelected= _tabController.index;
      });
    });
    
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        centerTitle: true,
        leading: IconButton(
            onPressed: widget.backButton, icon: Icon(Icons.arrow_back)),
        bottom:  TabBar(
          controller: _tabController,

          unselectedLabelColor: Colors.grey,


            indicatorColor: Colors.black,
            labelColor: Colors.black,

            tabs: [

              Tab(

                icon: Icon(
                  Icons.bar_chart,
                  color: isSelected==0?  Colors.green : Colors.grey,
                ),
                text: "Plan An Income",
              ),
              Tab(

                icon: Icon(Icons.bar_chart, color: isSelected==1? Colors.red:Colors.grey),
                text: "Plan An Expense",
              ),
            ]),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
        PlanAnIncomePage(
          userBox: widget.userBox,
          incomePlanButton: widget.incomePlanButton,
        ),
        PlanAnExpensePage(
          userBox: widget.userBox,
          expensePlanButton: widget.expensePlanButton,
        ),
      ]),
    );
  }
}
