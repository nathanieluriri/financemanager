import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PlanABudget extends StatefulWidget {
  final Box userBox;
  final VoidCallback planABudgetButton;
  final VoidCallback backButton;

  const PlanABudget(
      {super.key, required this.userBox, required this.planABudgetButton, required this.backButton});

  @override
  State<PlanABudget> createState() => _PlanABudgetState();
}

class _PlanABudgetState extends State<PlanABudget> {
  FocusNode nameFieldFocus = FocusNode();
  FocusNode incomeFieldFocus = FocusNode();
  final TextEditingController incomeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.addListener(() {
      widget.userBox.put("Budget Name", "${nameController.text}");
      widget.userBox.put("Budget Expected Income", "${incomeController.text}");
    });
    incomeController.addListener(() {
      _formatNumber(incomeController);
      widget.userBox.put("Budget Expected Income", "${incomeController.text}");
      widget.userBox.put("Budget Name", "${nameController.text}");
    });
  }

  void _formatNumber(TextEditingController controller) {
    final String text = controller.text.replaceAll(',', ''); // Remove commas
    if (text.isEmpty) return;

    final number = double.tryParse(text);
    if (number != null) {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          nameFieldFocus.unfocus();
          incomeFieldFocus.unfocus();
          widget.backButton();
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Setup A Monthly Budget",style: TextStyle(fontSize: 17),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GestureDetector(
          onTap: () {
            nameFieldFocus.unfocus();
            incomeFieldFocus.unfocus();
          },
          child: ListView(
            children: [
              Text("Plan A Budget using the 50/30/20 rule"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: nameFieldFocus,
                controller: nameController,
                decoration: InputDecoration(labelText: "Name Your Budget"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                focusNode: incomeFieldFocus,
                controller: incomeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "An amount you don't want to go over in a month",
                    labelText: "Expected Monthly Income Amount "),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[\d,.]*$'))
                ],
              ),
              SizedBox(
                height: 60,
              ),
              MaterialButton(
                onPressed: (){
                  nameFieldFocus.unfocus();
                  incomeFieldFocus.unfocus();
                  widget.planABudgetButton();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13))),
                color: Color(0xff4695F7),
                child: const SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                    "Plan Budget  ",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
