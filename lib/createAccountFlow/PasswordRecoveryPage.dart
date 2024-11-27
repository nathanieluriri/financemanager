import 'package:financemanager/Api/Auth/ChangePasswordApi.dart';
import 'package:financemanager/Api/Auth/PasswordRecoveryApi.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

class PasswordRecoveryPage extends StatefulWidget {
  final VoidCallback backButton;
  final Box userbox;

  const PasswordRecoveryPage({super.key, required this.backButton, required this.userbox});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.addListener((){

    });
    _otpController.addListener((){});
    _newPasswordController.addListener((){});
    _repeatPasswordController.addListener((){});
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool isValidEmail(String email) {
      final emailRegex = RegExp(
          r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.([a-zA-Z]{2,})$');
      return emailRegex.hasMatch(email);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Password Recovery"),
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
            print("I dey Password Recovery Page");
            _focusNode1.unfocus();
            _focusNode2.unfocus();
            _focusNode3.unfocus();
            _focusNode4.unfocus();
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text("Password Recovery"),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  focusNode: _focusNode1,
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || 
                        value.isEmpty ||
                        (!isValidEmail(value))) {
                      return 'Please enter a Valid Email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () async{
                    _focusNode1.unfocus();
                    _focusNode2.unfocus();
                    _focusNode3.unfocus();
                    _focusNode4.unfocus();
                    if (_formKey.currentState!.validate()) {

                    }
                    setState(() {

                    });
                    dynamic result= await sendOTPRequest(_emailController.text);
                    if (result==200){
                      print("Succesfully Sent Otp");
                      Fluttertoast.showToast(
                          msg: "Succesfully sent otp to your email",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueAccent,
                          textColor: Colors.white,
                          fontSize: 14.0
                      );
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "Couldn't Send Otp",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0
                      );
                    }
                  },
                  child: Container(
                      color: Colors.blue.shade50,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text("Send Otp"),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                isValidEmail(_emailController.value.text)
                    ? TextFormField(
                        focusNode: _focusNode2,
                        controller: _otpController,
                        decoration: InputDecoration(
                          labelText: 'Enter The Otp Sent To Your Email',
                          border: OutlineInputBorder(),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                isValidEmail(_emailController.value.text)
                    ? TextFormField(
                        focusNode: _focusNode3,
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Enter your New Password',
                          border: OutlineInputBorder(),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                isValidEmail(_emailController.value.text)
                    ? TextFormField(
                        focusNode: _focusNode4,
                        controller: _repeatPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Repeat your Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null ||value != _newPasswordController.text || value.isEmpty) {
                            return 'Error';
                          }
                          return null;
                        },
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                isValidEmail(_emailController.value.text)
                    ? MaterialButton(
                        onPressed: ()async {
                          _focusNode1.unfocus();
                          _focusNode2.unfocus();
                          _focusNode3.unfocus();
                          _focusNode4.unfocus();
                          if(_formKey.currentState!.validate()){

                            dynamic result = await verifyOtpAndPassword(_emailController.text,_otpController.text,_repeatPasswordController.text);
                            if (result==200){
                              Fluttertoast.showToast(
                                  msg: "Succesfully Changed Password",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blueAccent,
                                  textColor: Colors.white,
                                  fontSize: 14.0
                              );
                              widget.backButton();

                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Couldn't Change password $result",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 14.0
                              );
                            }
                          }
                        },
                        child: Container(
                            color: Colors.green.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Text("Change Password"),
                            )),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
