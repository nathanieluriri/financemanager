import 'package:flutter/material.dart';

class ColumnBuilder extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const ColumnBuilder({required this.itemCount, required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (index) => itemBuilder(context, index)),
    );
  }
}
