import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetTracker extends StatefulWidget {
  final String budgetName;
  final dynamic needsMaxAmount;
  final dynamic currentNeedsAmount;
  final dynamic percentageSpentNeedsAmount;
  final dynamic wantsMaxAmount;
  final dynamic currentwantsAmount;
  final dynamic percentageSpentWantsAmount;
  final dynamic savedAmount;
  final dynamic saveMaxAmount;
  final bool hasExceededSavings;
  final bool hasExceededNeeds;
  final bool hasExceededWants;
  final dynamic percentageSaved;

  const BudgetTracker(
      {super.key,
      required this.budgetName,
      required this.savedAmount,
      required this.percentageSaved,
      required this.needsMaxAmount,
      required this.currentNeedsAmount,
      required this.percentageSpentNeedsAmount,
      required this.wantsMaxAmount,
      required this.currentwantsAmount,
      required this.percentageSpentWantsAmount,
      required this.saveMaxAmount,
      required this.hasExceededSavings,
      required this.hasExceededNeeds,
      required this.hasExceededWants});

  @override
  State<BudgetTracker> createState() => _BudgetTrackerState();
}

class _BudgetTrackerState extends State<BudgetTracker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {},
          color: widget.hasExceededNeeds
              ? Colors.red.withOpacity(0.08)
              : Colors.blue.withOpacity(0.04),
          elevation: 5000,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Needs"),
                        Text("₦${widget.needsMaxAmount}")
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₦${widget.currentNeedsAmount}"),
                        widget.hasExceededNeeds
                            ? Text("over ${widget.percentageSpentNeedsAmount}%")
                            : Text("${widget.percentageSpentNeedsAmount}%")
                      ],
                    ),
                  ),
                  LinearPercentIndicator(
                    percent: widget.percentageSpentNeedsAmount / 100,
                    backgroundColor: Color(0xffffffff),
                    progressColor:
                        widget.hasExceededNeeds ? Colors.red : Colors.black,
                    animation: true,
                    animationDuration: 10000,
                    barRadius: Radius.circular(20),
                    animateFromLastPercent: true,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          onPressed: () {},
          color: widget.hasExceededWants
              ? Colors.red.withOpacity(0.08)
              : Colors.blue.withOpacity(0.04),
          elevation: 5000,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Wants"),
                        Text("₦${widget.wantsMaxAmount}")
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₦${widget.currentwantsAmount}"),
                        widget.hasExceededWants
                            ? Text("over ${widget.percentageSpentWantsAmount}%")
                            : Text("${widget.percentageSpentWantsAmount}%")
                      ],
                    ),
                  ),
                  LinearPercentIndicator(
                    percent: widget.percentageSpentWantsAmount / 100,
                    backgroundColor: Color(0xffffffff),
                    progressColor:
                        widget.hasExceededWants ? Colors.red : Colors.black,
                    animation: true,
                    animationDuration: 10000,
                    barRadius: Radius.circular(20),
                    animateFromLastPercent: true,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        MaterialButton(
          onPressed: () {},
          color: widget.hasExceededSavings
              ? Colors.green.withOpacity(0.08)
              : Colors.blue.withOpacity(0.04),
          elevation: 5000,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Saved"),
                        Text("₦${widget.saveMaxAmount}")
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₦${widget.savedAmount}"),
                        widget.hasExceededSavings
                            ? Text("over ${widget.percentageSaved}%")
                            : Text("${widget.percentageSaved}%")
                      ],
                    ),
                  ),
                  LinearPercentIndicator(
                    percent: widget.percentageSaved / 100,
                    backgroundColor: Color(0xffffffff),
                    progressColor:
                        widget.hasExceededSavings ? Colors.green : Colors.black,
                    animation: true,
                    animationDuration: 10000,
                    barRadius: Radius.circular(20),
                    animateFromLastPercent: true,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
