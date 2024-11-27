import 'dart:async';

import 'package:financemanager/Api/Goals/UpdateAGoalById.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GoalTracker extends StatefulWidget {
  final String goalName;
  final String goalId;
  final dynamic requiredAmount;
  final dynamic savedAmount;
  final dynamic percentageSaved;
  final VoidCallback onPressed;
  final String token;

  const GoalTracker(
      {super.key,
      required this.goalName,
      required this.requiredAmount,
      required this.savedAmount,
      required this.percentageSaved,
      required this.onPressed,
      required this.goalId,
      required this.token});

  @override
  State<GoalTracker> createState() => _GoalTrackerState();
}

class _GoalTrackerState extends State<GoalTracker> {
  final TextEditingController _accumulatedAmountController =
      TextEditingController();
  bool hasUpdated = false;

  int secondsPassed = 0;

  void _formatNumber(TextEditingController controller) {
    final String text = controller.text.replaceAll(',', ''); // Remove commas
    if (text.isEmpty) return;

    final number = double.tryParse(text);
    if (number != null) {
      print("object");
      // Format the number with commas
      final formatted = NumberFormat.decimalPattern().format(number);
      controller.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _accumulatedAmountController.addListener(() {
      _formatNumber(_accumulatedAmountController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        _accumulatedAmountController.text = "${widget.savedAmount}";
        showBarModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 38.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text("${widget.goalName}"),
                        TextFormField(
                          controller: _accumulatedAmountController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[\d,.]*$'))
                          ],
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: MaterialButton(
                            onPressed: () async {
                              dynamic response =
                                  await updateGoalAccumulatedAmount(
                                      goalId: widget.goalId,
                                      bearerToken: widget.token,
                                      accumulatedAmount: int.parse(
                                          _accumulatedAmountController.text
                                              .replaceAll(RegExp(r','), '')));

                              Fluttertoast.showToast(
                                  msg: " Status: - ${response['message']}",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 12.0);
                              if (response['status_code'] == 200) {
                                setState(() {
                                  hasUpdated = true;
                                });
                                Navigator.pop(context);
                              }
                              widget.onPressed();
                              setState(() {});
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                        )
                      ],
                    ),
                  ),
                ));
        widget.onPressed();
      },
      color:widget.percentageSaved == 100
          ? Colors.green.shade50: Colors.blue.withOpacity(0.06),
      elevation: 50000,
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${widget.goalName}"),
                    Text("₦${widget.requiredAmount}")
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("₦${widget.savedAmount}"),
                    Text("${widget.percentageSaved}%")
                  ],
                ),
              ),
              LinearPercentIndicator(
                percent: widget.percentageSaved / 100,
                backgroundColor: widget.percentageSaved == 100
                    ? Colors.green.withOpacity(0.6)
                    : Color(0xffffffff),
                progressColor: widget.percentageSaved == 100
                    ? Colors.green :Colors.black,
                animation: true,
                animationDuration: 10000,
                restartAnimation: true,
                barRadius: Radius.circular(20),
                animateFromLastPercent: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
