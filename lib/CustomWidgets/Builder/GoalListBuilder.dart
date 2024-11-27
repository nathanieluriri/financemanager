import 'package:financemanager/CustomWidgets/Builder/ColumnBuilder.dart';
import 'package:financemanager/CustomWidgets/GoalTrackingWidget.dart';
import 'package:flutter/cupertino.dart';

class Goallistbuilder extends StatefulWidget {
  final List Goals;
  final VoidCallback onPressed;
  final String token;

  const Goallistbuilder(
      {super.key,
      required this.Goals,
      required this.onPressed,
      required this.token});

  @override
  State<Goallistbuilder> createState() => _GoallistbuilderState();
}

class _GoallistbuilderState extends State<Goallistbuilder> {
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: widget.Goals.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              GoalTracker(
                onPressed: widget.onPressed,
                goalName: widget.Goals[index]['name'],
                requiredAmount: widget.Goals[index]['required_amount'],
                savedAmount: widget.Goals[index]['accumulated_amount'],
                percentageSaved: widget.Goals[index]['goal_percentage'],
                goalId: widget.Goals[index]['_id'],
                token: '${widget.token}',
              ),
              SizedBox(height: 12,)
            ],
          );
        });
  }
}
