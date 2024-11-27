import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback loginButton;
  final VoidCallback signUpButton;
  final VoidCallback forgottenPassword;
  final Box userdb;

  const LoginScreen(
      {super.key,
      required this.loginButton,
      required this.signUpButton,
      required this.forgottenPassword,
      required this.userdb});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  var animationLink = 'assets/login.riv';
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  SMIInput<SMINumber>? look;
  late StateMachineController? stateMachineController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController.addListener(() {
      widget.userdb.put("Login Email", _usernameController.value.text);
    });

    _passwordController.addListener(() {
      widget.userdb.put("Login Password", _passwordController.value.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("I dey Login Page");
        _focusNode1.unfocus();
        _focusNode2.unfocus();
        if (isHandsUp != null) {
          isHandsUp!.change(false);
        }

        if (isChecking != null) {
          isChecking!.change(false);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffD5E2EA),
        appBar: AppBar(
          title: const Text(
            'Login Page',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: const Color(0xffD5E2EA),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (artBoard != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: SizedBox(
                      height: 250,
                      child: RiveAnimation.asset(
                        animationLink,
                        fit: BoxFit.fitHeight,
                        stateMachines: ['Login Machine'],
                        onInit: (artBoard) {
                          stateMachineController =
                              StateMachineController.fromArtboard(
                                  artBoard, 'Login Machine');
                          if (stateMachineController == null) return;
                          artBoard.addController(stateMachineController!);
                          isChecking =
                              stateMachineController?.findInput('isChecking');
                          isHandsUp =
                              stateMachineController?.findInput('isHandsUp');
                          trigSuccess =
                              stateMachineController?.findInput('trigSuccess');
                          trigFail =
                              stateMachineController?.findInput('trigFail');
                          look = stateMachineController?.findInput("numLook");
                          print(look);
                        },
                      )),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD5E2EA),
                    // color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  height: 360.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              if (isHandsUp != null) {
                                isHandsUp!.change(false);
                              }
                              if (isChecking == null) return;
                              isChecking!.change(true);
                              _formKey.currentState!.validate();
                            },
                            onTap: () {
                              if (isHandsUp != null) {
                                isHandsUp!.change(false);
                              }
                              if (isChecking == null) return;
                              isChecking!.change(true);
                            },
                            controller: _usernameController,
                            focusNode: _focusNode1,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              // fillColor: Colors.grey.withOpacity(0.5),
                              fillColor: Colors.white38,
                              labelText: 'Email Address',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // Border color when focused
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                                // Border color when not focused
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                // Border color when not focused
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                // Border color when not focused
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email Address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            onChanged: (value) {
                              if (isHandsUp != null) {
                                isHandsUp!.change(true);
                              }
                              if (isChecking == null) return;
                              isChecking!.change(true);
                              _formKey.currentState!.validate();
                            },
                            onTap: () {
                              if (isChecking != null) {
                                isChecking!.change(false);
                              }
                              if (isHandsUp == null) return;
                              isHandsUp!.change(true);
                            },
                            controller: _passwordController,
                            focusNode: _focusNode2,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              // fillColor: Colors.grey.withOpacity(0.5),
                              fillColor: Colors.white38,
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                // Border color when focused
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                // Border color when not focused
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 40.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40.0,
                                width: 130.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(color: Colors.black)),
                                child: MaterialButton(
                                  onPressed: () {
                                    _focusNode1.unfocus();
                                    _focusNode2.unfocus();
                                    widget.signUpButton();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40.0,
                                width: 180.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    border: Border.all(color: Colors.black)),
                                child: MaterialButton(
                                  onPressed: () {
                                    _focusNode1.unfocus();
                                    _focusNode2.unfocus();
                                    widget.forgottenPassword();
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text(
                                    'Forgotten Password?',
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 29,
                          ),
                          Container(
                            height: 50.0,
                            width: 330.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25.0),
                                color: Colors.black),
                            child: MaterialButton(
                              onPressed: () {
                                _focusNode1.unfocus();
                                _focusNode2.unfocus();
                                if (_formKey.currentState!.validate()) {
                                  // Perform login logic here
                                  String username = _usernameController.text;
                                  String password = _passwordController.text;
                                  // Add your authentication logic here

                                  isChecking!.change(false);
                                  isHandsUp!.change(false);
                                  trigFail!.change(false);
                                  trigSuccess!.change(true);
                                } else {
                                  isChecking!.change(false);
                                  isHandsUp!.change(false);
                                  trigSuccess!.change(false);
                                  trigFail!.change(true);
                                }
                                widget.loginButton();
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
