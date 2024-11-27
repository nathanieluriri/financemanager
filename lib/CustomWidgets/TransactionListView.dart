
import 'package:financemanager/CustomWidgets/Builder/ColumnBuilder.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';





class Transactionlistview extends StatefulWidget {
  final List transactionList;
  const Transactionlistview({super.key, required this.transactionList});

  @override
  State<Transactionlistview> createState() => _TransactionlistviewState();
}

class _TransactionlistviewState extends State<Transactionlistview> {
  String formatNumber(int num) {
    final formatter = NumberFormat('#,##0');
    return formatter.format(num);
  }
  String formatDate(String isoDate) {
    // Parse the ISO date string into a DateTime object
    DateTime dateTime = DateTime.parse(isoDate);

    // Format the DateTime object into the desired format
    final formatter = DateFormat('dd/MM/yyyy'); // Define the desired format
    return formatter.format(dateTime);
  }
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
        itemCount: widget.transactionList.length ,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                trailing: widget.transactionList[index]['type']=='income'?
                Text(
                  "+₦${formatNumber(int.parse(widget.transactionList[index]['amount']))}",
                  style: TextStyle(color: Color(0xff46B09B)),
                ):Text(
                  "-₦${formatNumber(int.parse(widget.transactionList[index]['amount']))}",
                  style: TextStyle(color: Colors.red),
                )
                ,
                title: Text(
                  widget.transactionList[index]['name'],
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  "${formatDate(widget.transactionList[index]['createdAt'])}",
                  style: TextStyle(
                      color: Color(0xff909090), fontSize: 10),
                ),
              ),
              Divider(),
            ],
          );
        });
  }
}
