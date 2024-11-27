import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Categorypercentages extends StatefulWidget {
  final bool isIncome;
  final dynamic categoryName;
  final dynamic totalSpentOnCategory;
  final dynamic categoryPercentage;

  const Categorypercentages({super.key, this.isIncome = false, this.categoryName, this.totalSpentOnCategory,required this.categoryPercentage});

  @override
  State<Categorypercentages> createState() => _CategorypercentagesState();
}

class _CategorypercentagesState extends State<Categorypercentages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text("${widget.categoryName}"),
              Row(
                children: [
                  Text("${widget.categoryPercentage.round()}%"),
                  SizedBox(
                    width: 10,
                  ),
                 widget.isIncome? Text("₦${widget.totalSpentOnCategory}",style: TextStyle(color: Colors.green),): Text("₦${widget.totalSpentOnCategory}")
                ],
              )
            ],
          ),
        ),
        LinearPercentIndicator(
          percent: widget.categoryPercentage/100,
          backgroundColor: Color(0xaaD4D1D1),
          progressColor: Colors.black,
          animation: true,
          barRadius: Radius.circular(20),
          // restartAnimation: true,
          animationDuration: 1000,
          animateFromLastPercent: true,
        ),
      ],
    );
  }
}
