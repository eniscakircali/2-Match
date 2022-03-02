import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbti_match/screens/homepage.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  var name = Get.arguments;
  @override
  void initState() {
    super.initState();
    this._init();
  }

  void _init() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Delay to see the loading screen
    Get.to(() => const HomePage(),
        transition: Transition.rightToLeft,
        duration: const Duration(seconds: 1),
        arguments: name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            // Progress indicator before the redirection
            child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Loading..',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const CircularProgressIndicator(
                  backgroundColor: Colors.purple,
                  color: Colors.white,
                ),
              ]),
        )),
      ),
    );
  }
}
