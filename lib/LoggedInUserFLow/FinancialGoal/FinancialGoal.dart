import 'package:financemanager/CustomWidgets/Builder/GoalListBuilder.dart';
import 'package:financemanager/CustomWidgets/GoalTrackingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Goalspage extends StatefulWidget {
  final VoidCallback setUpNewGoalButton;
  final Box userBox;
  final VoidCallback editGoal;

  const Goalspage(
      {super.key,
      required this.setUpNewGoalButton,
      required this.userBox,
      required this.editGoal});

  @override
  State<Goalspage> createState() => _GoalspageState();
}

class _GoalspageState extends State<Goalspage> {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("I dey goals page");
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
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total saved",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    widget.userBox.get("Total Savings") == null
                                        ? Text("User Hasn't Saved Yet")
                                        : Text(
                                            "₦${widget.userBox.get("Total Savings")}",
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Fufiled Goals",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    widget.userBox.get('Goals Statistics') ==
                                            null
                                        ? Text(
                                            "User hasn't Activated Goals Yet")
                                        : Text(
                                            "${widget.userBox.get('Goals Statistics')}",
                                            style: TextStyle(fontSize: 12))
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
                      widget.userBox.get("Goals") == null ||
                              widget.userBox.get("Goals")!.length == 0
                          ? Center(
                              child: Container(
                                child: Column(
                                  children: [
                                    Icon(Icons.notifications_on_sharp),
                                    Text("Nothing here yet"),
                                  ],
                                ),
                              ),
                            )
                          : Goallistbuilder(
                              Goals: widget.userBox.get("Goals"),
                              onPressed: widget.editGoal, token: widget.userBox.get("Token"),
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
              onPressed: widget.setUpNewGoalButton,
              elevation: 100000,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: Colors.black,
              child: const SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  "Set Up A New Goal",
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
