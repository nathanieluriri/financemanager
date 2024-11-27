import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class SetupANewGoalPage extends StatefulWidget {
  final Box userbox;
  final VoidCallback planANewGoalButon;
  final VoidCallback backButton;
  const SetupANewGoalPage({super.key, required this.userbox, required this.planANewGoalButon, required this.backButton});

  @override
  State<SetupANewGoalPage> createState() => _SetupANewGoalPageState();
}

class _SetupANewGoalPageState extends State<SetupANewGoalPage> {
  FocusNode nameFieldFocus = FocusNode();
  FocusNode requiredAmountFieldFocus = FocusNode();
  FocusNode accumulatedAmountFieldFocus = FocusNode();
  final TextEditingController _requiredAmountController =
      TextEditingController();
  final TextEditingController _accumulatedAmountController =
      TextEditingController();
  final TextEditingController nameController =
  TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requiredAmountController.addListener(() {
      _formatNumber(_requiredAmountController);
      widget.userbox.put("Goal Name", "${nameController.text}");
      widget.userbox.put("Goal Required Amount", "${_requiredAmountController.text}");
      widget.userbox.put("Goal Accumulated Amount", "${_accumulatedAmountController.text}");
    });
    _accumulatedAmountController.addListener(() {
      _formatNumber(_accumulatedAmountController);
      widget.userbox.put("Goal Name", "${nameController.text}");
      widget.userbox.put("Goal Required Amount", "${_requiredAmountController.text}");
      widget.userbox.put("Goal Accumulated Amount", "${_accumulatedAmountController.text}");
    });
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: (){
          nameFieldFocus.unfocus();
          requiredAmountFieldFocus.unfocus();
          accumulatedAmountFieldFocus.unfocus();
          widget.backButton();
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Setup A Goal",style: TextStyle(fontSize: 17),),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GestureDetector(
          onTap: () {
            nameFieldFocus.unfocus();
            requiredAmountFieldFocus.unfocus();
            accumulatedAmountFieldFocus.unfocus();
          },
          child: ListView(
            children: [
              Text("Create A Goal"),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: nameFieldFocus,
                controller: nameController,
                decoration: InputDecoration(labelText: "Name of Goal"),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                focusNode: requiredAmountFieldFocus,
                controller: _requiredAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Required Amount"),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[\d,.]*$'))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                focusNode: accumulatedAmountFieldFocus,
                controller: _accumulatedAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Accumlated Amount"),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[\d,.]*$'))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: (){
                  nameFieldFocus.unfocus();
                  accumulatedAmountFieldFocus.unfocus();
                  requiredAmountFieldFocus.unfocus();
                  widget.planANewGoalButon();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(13))),
                color: Color(0xfa4695F7),
                child: const SizedBox(
                  height: 50,
                  child: Center(
                      child: Text(
                    "Setup Goal",
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
