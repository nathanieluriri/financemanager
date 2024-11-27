import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var animationLink = 'assets/login.riv';
  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? isHandsDown;
  SMIInput<SMITrigger>? trigSuccess;
  SMIInput<SMITrigger>? trigFail;
  SMIInput<SMINumber>? look;
  late StateMachineController? stateMachineController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          print("I dey Login Page");
          _focusNode1.unfocus();
          _focusNode2.unfocus();
        },
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black.withOpacity(0.2),
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside),
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.blue.withOpacity(0.03),
                backgroundBlendMode: BlendMode.hardLight,
              ),
              child: SizedBox(
                height: 350,
                child: RiveAnimation.asset(
                  animationLink,
                  fit: BoxFit.fill,
                  stateMachines: ['Login Machine'],
                  onInit: (artboard) {
                    stateMachineController =
                        StateMachineController.fromArtboard(
                            artboard, 'Login Machine');
                    if (stateMachineController == null) return null;
                    artboard.addController(stateMachineController!);

                    isChecking = stateMachineController?.findInput("isChecking");
                    isHandsUp = stateMachineController?.findInput("isHandsUp");


                    look = stateMachineController?.findInput("numLook");
                    print(look);

                    trigSuccess = stateMachineController?.findInput("trigSuccess");
                    trigFail = stateMachineController?.findInput("trigFail");
                  },
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Login"),
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
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              focusNode: _focusNode2,
              decoration: const InputDecoration(
                labelText: 'Enter your Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                if (isHandsUp != null) {
                  isHandsUp!.change(false);
                }
                if (isChecking == null) return;
                isChecking!.change(true);
              },
              onTap: (){
                if (isHandsUp != null) {
                  isHandsUp!.change(false);
                }
                if (isChecking == null) return;
                isChecking!.change(true);
              },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 90,
                  child: MaterialButton(
                    onPressed: (){},
                    child: Text("Sign Up"),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Text("Forgot Password?"),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
