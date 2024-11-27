import 'package:financemanager/CustomWidgets/BudgetTrackingWidget.dart';
import 'package:financemanager/CustomWidgets/GoalTrackingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MainBudgetPage extends StatefulWidget {
  final VoidCallback setUpNewBudgetButton;
  final Box userBox;

  const MainBudgetPage(
      {super.key, required this.setUpNewBudgetButton, required this.userBox});

  @override
  State<MainBudgetPage> createState() => _MainBudgetPageState();
}

class _MainBudgetPageState extends State<MainBudgetPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("I dey Budget page");
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text("Hello! ${widget.userBox.get("First Name")}"),
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              // Shadow color with opacity
                              blurRadius: 40.0,
                              // How soft the shadow is
                              offset:
                                  Offset(4, 4), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Color(0XFF46B09B),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(0XFFE4FFDD),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total saved",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    widget.userBox
                                        .get('Budget')?['savings_budget']==null?
                                        Text("Budget Not Active"):
                                    Text(
                                        "₦${widget.userBox.get("Total Savings")}/₦${widget.userBox
                                            .get('Budget')['savings_budget']}",
                                        style: TextStyle(fontSize: 12))
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
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              // Shadow color with opacity
                              blurRadius: 40.0,
                              // How soft the shadow is
                              offset: Offset(
                                  40, 1), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.userBox
                                    .get('Budget')?['is_total_income_exceeded']??false
                                ? Colors.red.withOpacity(0.08)
                                : Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),

                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 15),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    Icons.rocket_launch,
                                    color: Color(0XFF46B09B),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Color(0XFFE4FFDD),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total spent",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      widget.userBox
                                          .get('Budget')?['savings_budget']==null?
                                      Text("Budget Not Active"):
                                      Text(
                                          "₦${widget.userBox.get('Total Spent')}/₦${widget.userBox.get('Budget')['total_income']}",
                                          style: TextStyle(fontSize: 12))
                                    ],
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
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 370,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.userBox.get("Budget") == null ||
                              widget.userBox.get("Budget").toString().isEmpty
                          ? Container(
                              child: Column(
                                children: [
                                  Icon(Icons.notifications_on_sharp),
                                  Text("Nothing here yet"),
                                ],
                              ),
                            )
                          : BudgetTracker(
                              budgetName: "Monthly Budget",
                              savedAmount: widget.userBox
                                  .get("Budget")["savings_amount"],
                              percentageSaved: widget.userBox
                                  .get("Budget")["savings_percentage"],
                              needsMaxAmount:
                                  widget.userBox.get("Budget")["needs_budget"],
                              currentNeedsAmount: widget.userBox
                                  .get("Budget")["needs_spent_amount"],
                              percentageSpentNeedsAmount: widget.userBox
                                  .get("Budget")["needs_spent_percent"],
                              wantsMaxAmount:
                                  widget.userBox.get("Budget")["wants_budget"],
                              currentwantsAmount: widget.userBox
                                  .get("Budget")["wants_spent_amount"],
                              percentageSpentWantsAmount: widget.userBox
                                  .get("Budget")["wants_spent_percent"],
                              saveMaxAmount: widget.userBox
                                  .get("Budget")["savings_budget"],
                              hasExceededSavings: widget.userBox.get("Budget")[
                                  "is_savings_over_available_balance"],
                              hasExceededNeeds: widget.userBox.get(
                                  "Budget")["is_needs_over_available_balance"],
                              hasExceededWants: widget.userBox.get(
                                  "Budget")["is_wants_over_available_balance"],
                            ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: widget.setUpNewBudgetButton,
              elevation: 100000,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: Colors.black,
              child: const SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  "Set Up A New Budget",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
