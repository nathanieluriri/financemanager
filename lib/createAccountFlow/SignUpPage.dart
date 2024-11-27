import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Signuppage extends StatefulWidget {
  final VoidCallback signUpButton;
  final VoidCallback backButton;
  final Box userbox;
  const Signuppage(
      {super.key, required this.signUpButton, required this.backButton, required this.userbox});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  TextEditingController firstName= TextEditingController();
  TextEditingController secondName= TextEditingController();
  TextEditingController password= TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstName.addListener((){
      widget.userbox.put("First Name",firstName.value.text);

    });
    secondName.addListener((){
      widget.userbox.put("Second Name",secondName.value.text);
      print(widget.userbox.get("Second Name"));
      print(widget.userbox.get("Second Name"));
      print(widget.userbox.get("Second Name"));
      print(widget.userbox.get("Second Name"));
      print(widget.userbox.get("Second Name"));
      print(widget.userbox.get("Second Name"));
    });
    password.addListener((){
      widget.userbox.put("Password",password.value.text);
      widget.userbox.put("Password",password.value.text);

    });
    email.addListener((){
      widget.userbox.put("Email",email .value.text);

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _focusNode1.unfocus();
              _focusNode2.unfocus();
              _focusNode3.unfocus();
              _focusNode4.unfocus();
              widget.backButton();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {

            _focusNode1.unfocus();
            _focusNode2.unfocus();
            _focusNode3.unfocus();
            _focusNode4.unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode1,
                controller: firstName,

                decoration: InputDecoration(
                  labelText: 'Enter your First name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode2,
                controller: secondName,
                decoration: const InputDecoration(
                  labelText: 'Enter your Second Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode3,
                controller: email,
                decoration: const InputDecoration(
                  labelText: 'Enter your Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode4,
                obscureText: true,
                controller: password,
                decoration: const InputDecoration(
                  labelText: 'Enter A Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  _focusNode1.unfocus();
                  _focusNode2.unfocus();
                  _focusNode3.unfocus();
                  _focusNode4.unfocus();
                  widget.signUpButton();
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
