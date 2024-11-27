

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Incomebarchart extends StatefulWidget {
  const Incomebarchart({super.key});

  @override
  State<Incomebarchart> createState() => _IncomebarchartState();
}

class _IncomebarchartState extends State<Incomebarchart> {
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 300,
      child: LineChart(
        LineChartData(

            gridData: FlGridData(
              show: true,


            ),
            borderData: FlBorderData(
                show: true,
                border: Border.all(
                  width: 0.2,

                )

            ),
            maxX: 30,
            minX: 1,


            titlesData: const FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                axisNameWidget: Text("Date"),

              ),
              leftTitles: AxisTitles(
                  axisNameWidget: Text("Income")
              ),

            ),
            lineBarsData:[
              LineChartBarData(
                  isCurved: true,

                  spots: [
                    FlSpot(1, 22000),
                    FlSpot(2, 44000),
                    FlSpot(3, 44000),
                    FlSpot(4, 24000),
                    FlSpot(5, 54000),
                    FlSpot(6, 200),
                    FlSpot(7, 1200),
                    FlSpot(8, 00),
                  ]

              )

            ]
        ),
      ),
    )
    ;
  }
}
