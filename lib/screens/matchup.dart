// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mbti_match/screens/homepage.dart';
import 'package:mbti_match/screens/requests.dart';
import 'package:mbti_match/services/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MatchUp extends StatefulWidget {
  const MatchUp({Key? key}) : super(key: key);

  @override
  _Matchup createState() => _Matchup();
}

class _Matchup extends State<MatchUp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<int> _counter;
  int _selectedIndex = 1;
  var name = Get.arguments[0];
  var types = Get.arguments[1];
  var typesDetails = Get.arguments[2];
  var type = Get.arguments[3];
  var matchedUserTypeDetails = "";
  var userMatchesDocument;
  var userMatchName = "";
  var userMatchType = "";
  var paramName, paramValue;
  int indexofMatch = 0;
  bool flag =
      false; // for getmaches function which is async. Async property gives that function to make calling itself over and over again.
  int matchesCounter = 0;
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
            transition: Transition.rightToLeft,
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

  Future<void> cardIndexCounter() async {
    // this function helping user to get last match index with using shared preferences
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    setState(() {
      _counter = prefs.setInt('counter', counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      return prefs.getInt('counter') ?? 0;
    });
  }

  void getMatches() async {
    // this function connecting server and gettin our data. Data contains id, name, type ...
    await Functions().findMatch(type).then((type) {
      if (type.data['success']) {
        setState(() {
          userMatchesDocument = type.data['msg'];
        });
      }
    });
    await editMatches();
  }

  editMatches() async {
    // this function editing our raw data to useful data.
    if (userMatchesDocument[indexofMatch]["name"] != name) {
      setState(() {
        // this condition asks for is user who logged in and matched user are the same user.
        userMatchName = (userMatchesDocument[indexofMatch]["name"]);
        userMatchType = (userMatchesDocument[indexofMatch]["type"]);
        paramName = userMatchName;
        paramValue = name;
      });
      findTypeDetails(); // we need to get type info
    } else if (indexofMatch == userMatchesDocument.length - 1) {
      // this condition asking for the index of user is the last index in matches. If it is, seting indexofmatches to zero.
      setState(() {
        indexofMatch == 0;
      });
      editMatches();
    } else {
      setState(() {
        indexofMatch++;
      });
      editMatches();
    }
  }

  findTypeDetails() async {
    // this function getting type info by matched user type
    for (var i = 0; i < 16; i++) {
      if (userMatchType == types[i]) {
        setState(() {
          matchedUserTypeDetails = typesDetails[i];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 80,
                ),
                cardBuilder() // cardbuilder calling itself by itemcount variable
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

  cardBuilder() {
    if (flag == false) {
      getMatches();
      setState(() {
        flag == true;
      });
    }
    // firstly we need to connect with our server to get our data.
    return SizedBox(
      height: 550,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 0,
              color: Colors.transparent,
              margin: const EdgeInsets.all(15),
              child: Container(
                width: 300,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 1),
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.025),
                      spreadRadius: 1,
                      blurRadius: 1, // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Builder(builder: (context) {
                          return const CircleAvatar(
                            radius: 60,
                          );
                        }),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          userMatchName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      userMatchType,
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      matchedUserTypeDetails,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 12,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                          ),
                          onPressed: () async {
                            await Functions()
                                .sendRequest(paramName, paramValue)
                                .then((paramName) {
                              if (paramName.data['success']) {
                                setState(() {
                                  // ignore: avoid_print
                                  print("success");
                                });
                              }
                            });
                            if (userMatchesDocument.length - 1 > indexofMatch) {
                              setState(() {
                                indexofMatch++;
                              });
                            } else {
                              setState(() {
                                indexofMatch = 0;
                              });
                            }
                            cardIndexCounter();
                            editMatches();
                          },
                          child: const Icon(
                            Icons.add_comment,
                            size: 40,
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                          ),
                          onPressed: () {
                            if (userMatchesDocument.length - 1 > indexofMatch) {
                              setState(() {
                                indexofMatch++;
                              });
                            } else {
                              setState(() {
                                indexofMatch = 0;
                              });
                            }
                            cardIndexCounter();
                            editMatches();
                          },
                          child: const Icon(
                            Icons.dangerous_sharp,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
