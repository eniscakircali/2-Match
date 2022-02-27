// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbti_match/screens/homepage.dart';
import 'package:mbti_match/screens/requests.dart';
import 'package:mbti_match/screens/matchup.dart';

import '../services/functions.dart';

class Matches extends StatefulWidget {
  const Matches({Key? key}) : super(key: key);

  @override
  _Matches createState() => _Matches();
}

class _Matches extends State<Matches> {
  var name = Get.arguments[0];
  var types = Get.arguments[1];
  var typesDetails = Get.arguments[2];
  var type = Get.arguments[3];
  int _selectedIndex = 2;
  var matchesDocument;
  int tempCounter =
      0; // this variable avoiding listbuilder() from getting error when requestdocument.length method returning null
  bool flag = false;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Get.to(() => const HomePage(),
            transition: Transition.leftToRight,
            duration: const Duration(seconds: 1),
            arguments: name);
      }
      if (index == 1) {
        Get.to(() => const MatchUp(),
            transition: Transition.leftToRight,
            duration: const Duration(seconds: 1),
            arguments: [name, types, typesDetails, type]);
      }
      if (index == 2) {
        Get.to(() => const Requests(),
            transition: Transition.rightToLeft,
            duration: const Duration(seconds: 1),
            arguments: [name, types, typesDetails, type]);
      }
    });
  }

  Future<void> getMatches() async {
    // this method connecting to our server and geting our data from database
    await Functions().getRequests(name).then((name) {
      if (name.data['success']) {
        setState(() {
          matchesDocument = name.data['msg']['matches'];
          if (matchesDocument != null) {
            matchesDocument = matchesDocument.split(',');
            tempCounter = matchesDocument.length -
                1; // we subtracting because our matches variable taking first element as a value called undefined
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => const Requests(),
                              duration: const Duration(seconds: 1),
                              arguments: [name, types, typesDetails, type]);
                        },
                        child: const Text("Requests",
                            style: TextStyle(color: Colors.grey)),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 40),
                            primary: Colors.grey[200]),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          "Matches",
                        ),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(120, 40),
                            primary: Colors.purple),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 650,
                  child: listBuilder(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Match-Up',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'Matches',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.purple[800],
            onTap: _onItemTapped,
          ),
          backgroundColor: Colors.white),
    );
  }

  listBuilder() {
    if (flag == false) {
      getMatches();
      setState(() {
        flag = true;
      });
    } // method call for geting our data from server
    return ListView.builder(
        itemCount: tempCounter,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
              height: 170,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple),
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purpleAccent.withOpacity(0.025),
                          spreadRadius: 1,
                          blurRadius: 1, // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  const CircleAvatar(
                                    radius: 25,
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    matchesDocument[index + 1],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(matchesDocument[index + 1]),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Get Username"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.purple[300], elevation: 5),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
