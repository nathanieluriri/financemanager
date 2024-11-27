import 'dart:async';

import 'package:financemanager/CustomWidgets/TransactionListView.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Overview extends StatefulWidget {
  final Box accountDetails;
  final VoidCallback floatingActionButton;
  final VoidCallback moveToReportPage;
  final VoidCallback moveToGoalPage;

  const Overview(
      {super.key,
      required this.accountDetails,
      required this.floatingActionButton,
      required this.moveToReportPage,
      required this.moveToGoalPage});

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  bool hideBalanceSwitch = false;
  String totalBalance = "0";
  String totalIncome = "0";
  String totalExpense = "0";
  late Timer _balanceTimer;

  void formatNumber(int balanceNumbers, int incomeNumber, int expenseNumber) {
    final formatter = NumberFormat('#,##0');
    if (mounted) {
      setState(() {
        totalBalance = formatter.format(balanceNumbers);
        totalExpense = formatter.format(expenseNumber);
        totalIncome = formatter.format(incomeNumber);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _balanceTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      widget.accountDetails.put("Is Overview Loading",
          (widget.accountDetails.get("Is Overview Loading") ?? 0) + 1);
      formatNumber(
          widget.accountDetails.get("balance") ?? 0,
          widget.accountDetails.get("totalIncome") ?? 0,
          widget.accountDetails.get("totalExpense") ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Expense and Income Overview Tools",
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        leading: Icon(Icons.add_box_rounded),
        backgroundColor: Colors.orange.withOpacity(0.05),
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: GestureDetector(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xffFEF8E8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Total Balance"),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    hideBalanceSwitch
                                        ? Text("******",
                                            style: TextStyle(fontSize: 25))
                                        : Text(
                                            "₦$totalBalance",
                                            style: TextStyle(fontSize: 25),
                                          ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text("Hide Balance"),
                                          Switch(
                                              activeColor: Color(0xffFEF8E8),
                                              activeTrackColor:
                                                  Color(0xff000000),
                                              inactiveTrackColor:
                                                  Color(0xffffffff),
                                              inactiveThumbColor:
                                                  Color(0xff000000),
                                              value: hideBalanceSwitch,
                                              onChanged: (value) {
                                                setState(() {
                                                  hideBalanceSwitch = value;
                                                });
                                              })
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 15),
                          child: Text(
                              "Hi! ${widget.accountDetails.get("First Name")} ${widget.accountDetails.get("Second Name")}"),
                        ),
                        SizedBox(
                          height: 90,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageView(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          // Shadow color with opacity
                                          blurRadius: 40.0,
                                          // How soft the shadow is
                                          offset: Offset(4,
                                              4), // Position of the shadow (x, y)
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: Icon(
                                              Icons.keyboard_arrow_up,
                                              color: Color(0XFFE67646),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color(0XFFFFEDDD),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 15),
                                            child: Column(
                                              children: [
                                                Text("Expense"),
                                                Text("₦$totalExpense")
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.03),
                                          // Shadow color with opacity
                                          blurRadius: 40.0,
                                          // How soft the shadow is
                                          offset: Offset(40,
                                              1), // Position of the shadow (x, y)
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 1.0,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0XFF46B09B),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Color(0XFFEDF5E8),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0, vertical: 15),
                                            child: Column(
                                              children: [
                                                Text("Income"),
                                                Text("₦$totalIncome"),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 8.0),
                  child: Text(
                    "Transactions",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 20,
                ),
                SizedBox(
                  height: 330,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.accountDetails.get('transactions') == null || widget.accountDetails.get('transactions')?.isEmpty
                            ? widget.accountDetails.get("Is Overview Loading") <
                                        20 ??
                                    false
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 30,),
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    ],
                                  )
                                : Image(image: AssetImage("assets/tooltip.png"),)

                            : widget.accountDetails.get("Is Overview Loading") <
                                        20 ??
                                    false
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(width: 30,),
                                          CircularProgressIndicator(),
                                        ],
                                      ),                                 ],
                                  )
                                : Transactionlistview(
                                    transactionList: widget.accountDetails
                                        .get('transactions'))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        elevation: 100000,
        onPressed: () {
          widget.floatingActionButton();
        },
        backgroundColor: Colors.orange.shade50.withOpacity(0.5),
        child: Icon(Icons.add),
      ),
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
        currentIndex: 0,
        // Highlight the selected item
        selectedItemColor: Colors.orange.shade200,
        // Color of the selected item
        onTap: (value) {
          if (value == 1) {
            widget.moveToReportPage();
          } else if (value == 2) {
            widget.moveToGoalPage();
          }
        }, // Handle tab taps
      ),
    );
  }
}
