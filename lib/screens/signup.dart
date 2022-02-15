// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mbti_match/screens/signin.dart';
import 'package:mbti_match/services/functions.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  // regex for username and password.
  static final validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  static final passwordValidCharacters = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  var name, password, nickname, token;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                // form for validation
                key: _formKey,
                child: Column(
                  children: [
                    nameForm(),
                    const SizedBox(
                      height: 15,
                    ),
                    nicknameForm(),
                    const SizedBox(
                      height: 15,
                    ),
                    passwordForm(),
                    const SizedBox(
                      height: 15,
                    ),
                    acceptButton()
                  ],
                ))
          ],
        ),
      ),
    );
  }

  nameForm() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Name",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter some text';
        } else if (val.length <= 3) {
          return 'Name is too short';
        } else if (val.length >= 16) {
          return 'Name is too long';
        } else if (validCharacters.hasMatch(val) == false) {
          return 'Special characters are not allowed';
        } else {
          name = val;
        }
        return null;
      },
    );
  }

  nicknameForm() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "NickName",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter some text';
        } else if (val.length <= 3) {
          return 'Name is too short';
        } else if (val.length >= 16) {
          return 'Name is too long';
        } else {
          nickname = val;
        }
        return null;
      },
    );
  }

  passwordForm() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(),
        ),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter some text';
        } else if (val.length <= 7) {
          return 'Password is too short';
        } else if (val.length >= 20) {
          return 'Password is too long';
        } else if (passwordValidCharacters.hasMatch(val) == false) {
          return 'Spaces are not allowed';
        } else {
          password = val;
        }
        return null;
      },
    );
  }

  acceptButton() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.blueGrey,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Functions().addUser(name, password, nickname).then((val) {
              if (val.data['success']) {
                token = val.data['token'];
                Fluttertoast.showToast(
                    msg: 'Successfully Signed Up',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16);
                Get.to(
                  () => const Signin(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(seconds: 1),
                );
              } else {
                Fluttertoast.showToast(
                    msg: 'This name already used.',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red[800],
                    textColor: Colors.white,
                    fontSize: 16);
              }
            });
          }
        },
      ),
    );
  }
}
