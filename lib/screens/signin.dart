// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mbti_match/screens/homepage.dart';
import 'package:mbti_match/screens/survey.dart';
import 'package:mbti_match/screens/signup.dart';
import 'package:mbti_match/services/functions.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var name, password, token;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextField(
                  // TextField for users name
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (val) {
                    name = val;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  // TextField for users password
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                const SizedBox(height: 20),
                buttons(),
              ],
            ),
          ),
        ));
  }

  buttons() {
    // this function contains two buttons and each button has different function and routing.
    return Column(
      children: [
        // button for sign in
        ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Colors.green),
          child: const Text(
            "Sign In",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Functions().login(name, password).then((val) {
              // function call for login()
              if (val.data['success']) {
                token = val.data['token'];
                Fluttertoast.showToast(
                    msg: 'Authenticated',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16);
                Functions().flagCheck(name).then((val) {
                  // function call for checking user has a type or not
                  if (val.data['success']) {
                    // if user has a type go directly our homepage
                    Get.to(() => const HomePage(),
                        arguments: name,
                        duration: const Duration(seconds: 1),
                        transition: Transition.rightToLeft);
                  } else {
                    // if not, go to the survey page to get type.
                    Get.to(() => const Survey(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(seconds: 1),
                        arguments: name);
                  }
                });
              }
            });
          },
        ),
        const SizedBox(
          height: 10,
        ),
        //button for route to page signup
        ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.blue),
            child: const Text(
              "Sign Up",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              Get.to(
                () => const Signup(),
                transition: Transition.rightToLeft,
                duration: const Duration(seconds: 1),
              );
            })
      ],
    );
  }
}
