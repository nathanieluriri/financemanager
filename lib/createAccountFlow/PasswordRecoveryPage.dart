import 'package:flutter/material.dart';

class PasswordRecoveryPage extends StatefulWidget {
  final VoidCallback backButton;

  const PasswordRecoveryPage({super.key, required this.backButton});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Password Recovery"),
        leading: IconButton(
            onPressed: widget.backButton, icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            print("I dey Password Recovery Page");
            _focusNode1.unfocus();
            _focusNode2.unfocus();
            _focusNode3.unfocus();
            _focusNode4.unfocus();
          },
          child: ListView(
            children: [
              Text("Password Recovery"),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode1,
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
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode2,
                decoration: InputDecoration(
                  labelText: 'Enter The Otp Sent To Your Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                focusNode: _focusNode3,
                decoration: InputDecoration(
                  labelText: 'Enter your New Password',
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
                decoration: const InputDecoration(
                  labelText: 'Repeat your Password',
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
                onPressed: () {},
                child: const Text("Change Password"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
