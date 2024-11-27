import 'package:financemanager/CustomWidgets/Builder/ColumnBuilder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class PlanAnExpensePage extends StatefulWidget {
  final Box userBox;
  final VoidCallback expensePlanButton;

  const PlanAnExpensePage(
      {super.key, required this.userBox, required this.expensePlanButton});

  @override
  State<PlanAnExpensePage> createState() => _PlanAnExpensePageState();
}

class _PlanAnExpensePageState extends State<PlanAnExpensePage> {
  FocusNode nameFieldFocus = FocusNode();
  FocusNode requiredAmountFieldFocus = FocusNode();
  FocusNode accumulatedAmountFieldFocus = FocusNode();
  FocusNode categoryFieldFocus = FocusNode();
  bool buttonActive = false;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _amountController.addListener(() {
      _formatNumber(_amountController);
      validateForm();
      widget.userBox.put("Transaction Amount", _amountController.text);
      widget.userBox.put("Category Name", _categoryController.text);
      widget.userBox.put("Transaction Name", _nameController.text);
    });
    _nameController.addListener(() {
      _formatNumber(_nameController);
      validateForm();
      widget.userBox.put("Transaction Amount", _amountController.text);
      widget.userBox.put("Category Name", _categoryController.text);
      widget.userBox.put("Transaction Name", _nameController.text);
    });
    _categoryController.addListener(() {
      validateForm();
      widget.userBox.put("Transaction Amount", _amountController.text);
      widget.userBox.put("Category Name", _categoryController.text);
      widget.userBox.put("Transaction Name", _nameController.text);
    });
  }

  void validateForm() {
    if (_amountController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty) {
      setState(() {
        buttonActive = true;
      });
    } else {
      setState(() {
        buttonActive = false;
      });
    }
  }

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GestureDetector(
        onTap: () {
          nameFieldFocus.unfocus();
          requiredAmountFieldFocus.unfocus();
          accumulatedAmountFieldFocus.unfocus();
          categoryFieldFocus.unfocus();
        },
        child: ListView(
          children: [
            Text("Plan An Expense By Category"),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: nameFieldFocus,
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name of Transaction"),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode: requiredAmountFieldFocus,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter An Amount"),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[\d,.]*$'))
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode: categoryFieldFocus,
              readOnly: true,
              controller: _categoryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Category"),
              onTap: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    child: ColumnBuilder(
                        itemCount:
                            widget.userBox.get("Expense Categories").length,
                        itemBuilder: (context, index) {
                          return Material(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 38.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(widget.userBox
                                            .get("Expense Categories")[index]
                                        ['category_name']),
                                    subtitle: Text(
                                        "${widget.userBox.get('Expense Categories')[index]['priority_type']}"),
                                    onTap: () {
                                      _categoryController.text = widget.userBox
                                              .get("Expense Categories")[index]
                                          ['category_name'];
                                      widget.userBox.put(
                                          "Selected Category Id",
                                          widget.userBox.get(
                                                  "Expense Categories")[index]
                                              ['_id']);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                );
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^[\d,.]*$'))
              ],
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButton(
              elevation: 10000,
              onPressed: buttonActive
                  ? () {
                      nameFieldFocus.unfocus();
                      requiredAmountFieldFocus.unfocus();
                      accumulatedAmountFieldFocus.unfocus();
                      categoryFieldFocus.unfocus();
                      widget.expensePlanButton();
                    }
                  : () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13))),
              color: buttonActive ? Colors.black : Colors.grey.shade300,
              child: const SizedBox(
                height: 50,
                child: Center(
                    child: Text(
                  "Plan Expense",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
