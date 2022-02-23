import 'package:flutter/material.dart';
import 'package:mbti_match/screens/requests.dart';
import 'package:mbti_match/screens/matchup.dart';
import 'package:get/get.dart';
import 'package:mbti_match/screens/signin.dart';
import 'package:mbti_match/services/functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var name = Get.arguments;
  var type = "";
  var userType = "";
  var types = [
    'ENFJ',
    'ENTJ',
    'ENFP',
    'ENTP',
    'ESFJ',
    'ESFP',
    'ESTJ',
    'ESTP',
    'INFJ',
    'INFP',
    'INTJ',
    'INTP',
    'ISFJ',
    'ISFP',
    'ISTJ',
    'ISTP'
  ];
  var typesDetails = [
    ("ENFJs are people-focused individuals. They live in the world of people possibilities. More so than any other type, they have excellent people skills. They understand and care about people, and have a special talent for bringing out the best in others. ENFJ's main interest in life is giving love, support, and a good time to other people. They are focused on understanding, supporting, and encouraging others. They make things happen for people, and get their best personal satisfaction from this."),
    ("ENTJ's are natural born leaders. They live in a world of possibilities where they see all sorts of challenges to be surmounted, and they want to be the ones responsible for surmounting them. They have a drive for leadership, which is well-served by their quickness to grasp complexities, their ability to absorb a large amount of impersonal information, and their quick and decisive judgments. They are 'take charge' people."),
    ("ENFPs are warm, enthusiastic people, typically very bright and full of potential. They live in the world of possibilities, and can become very passionate and excited about things. Their enthusiasm lends them the ability to inspire and motivate others, more so than we see in other types. They can talk their way in or out of anything. They love life, seeing it as a special gift, and strive to make the most out of it"),
    ("With Extraverted Intuition dominating their personality, the ENTP's primary interest in life is understanding the world that they live in. They are constantly absorbing ideas and images about the situations they are presented in their lives. Using their intuition to process this information, they are usually extremely quick and accurate in their ability to size up a situation. With the exception of their ENFP cousin, the ENTP has a deeper understanding of their environment than any of the other types"),
    ("ESFJ's are people persons - they love people. They are warmly interested in others. They use their Sensing and Judging characteristics to gather specific, detailed information about others, and turn this information into supportive judgments. They want to like people, and have a special skill at bringing out the best in others. They are extremely good at reading others, and understanding their point of view. The ESFJ's strong desire to be liked and for everything to be pleasant makes them highly supportive of others. People like to be around ESFJ’s, because the ESFJ has a special gift of invariably making people feel good about themselves."),
    ("ESFP’s have very strong inter-personal skills, and may find themselves in the role of the peacemaker frequently. Since they make decisions by using their personal values, they are usually very sympathetic and concerned for other people's well-being. They're usually quite generous and warm. They are very observant about other people, and seem to sense what is wrong with someone before others might, responding warmly with a solution to a practical need. They might not be the best advice-givers in the world, because they dislike theory and future-planning, but they are great for giving practical care."),
    ("ESTJ's live in a world of facts and concrete needs. They live in the present, with their eye constantly scanning their personal environment to make sure that everything is running smoothly and systematically. They honor traditions and laws, and have a clear set of standards and beliefs. They expect the same of others, and have no patience or understanding of individuals who do not value these systems. They value competence and efficiency, and like to see quick results for their efforts."),
    ("ESTP's are outgoing, straight-shooting types. Enthusiastic and excitable, ESTP’s are 'doers' who live in the world of action. Blunt, straight-forward risk-takers, they are willing to plunge right into things and get their hands dirty. They live in the here-and-now, and place little importance on introspection or theory. They look at the facts of a situation, quickly decide what should be done, execute the action, and move on to the next thing."),
    ("INFJ's are gentle, caring, complex and highly intuitive individuals. Artistic and creative, they live in a world of hidden meanings and possibilities. Only one percent of the population has an INFJ Personality Type, making it the rarest of all the types."),
    ("INFP's, more than other iNtuitive Feeling types, are focused on making the world a better place for people. Their primary goal is to find out their meaning in life. What is their purpose? How can they best serve humanity in their lives? They are idealists and perfectionists, who drive themselves hard in their quest for achieving the goals they have identified for themselves"),
    ("INTJ's live in the world of ideas and strategic planning. They value intelligence, knowledge, and competence, and typically have high standards in these regards, which they continuously strive to fulfill. To a somewhat lesser extent, they have similar expectations of others"),
    ("INTP's live in the world of theoretical possibilities. They see everything in terms of how it could be improved, or what it could be turned into. They live primarily inside their own minds, having the ability to analyze difficult problems, identify patterns, and come up with logical explanations. They seek clarity in everything, and are therefore driven to build knowledge. They are the 'absent-minded professors', who highly value intelligence and the ability to apply logic to theories to find solutions. They typically are so strongly driven to turn problems into logical explanations, that they live much of their lives within their own heads, and may not place as much importance or value on the external world. Their natural drive to turn theories into concrete understanding may turn into a feeling of personal responsibility to solve theoretical problems, and help society move towards a higher understanding."),
    ("ISFJ's live in a world that is concrete and kind. They are truly warm and kind-hearted, and want to believe the best of people. They value harmony and cooperation, and are likely to be very sensitive to other people's feelings. People value the ISFJ for their consideration and awareness, and their ability to bring out the best in others by their firm desire to believe the best."),
    ("ISFP's live in the world of sensation possibilities. They are keenly in tune with the way things look, taste, sound, feel and smell. They have a strong aesthetic appreciation for art, and are likely to be artists in some form, because they are unusually gifted at creating and composing things which will strongly affect the senses. They have a strong set of values, which they strive to consistently meet in their lives. They need to feel as if they're living their lives in accordance with what they feel is right, and will rebel against anything which conflicts with that goal. They're likely to choose jobs and careers which allow them the freedom of working towards the realization of their value-oriented personal goals"),
    ("ISTJ's are quiet and reserved individuals who are interested in security and peaceful living. They have a strongly-felt internal sense of duty, which lends them a serious air and the motivation to follow through on tasks. Organized and methodical in their approach, they can generally succeed at any task which they undertak"),
    ("ISTP's have a compelling drive to understand the way things work. They're good at logical analysis, and like to use it on practical concerns. They typically have strong powers of reasoning, although they're not interested in theories or concepts unless they can see a practical application. They like to take things apart and see the way they work."),
  ];
  int _selectedIndex = 0;
  bool flag = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Get.to(() => const HomePage(),
            transition: Transition.rightToLeft,
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

  void gettype() async {
    // function call for geting usertype by name
    await Functions().getType(name).then((name) {
      if (name.data['success']) {
        setState(() {
          type = name.data['msg'].toString();
          findType();
        });
      }
    });
  }

  void findType() async {
    // function for find user type for show details.
    for (var i = 0; i < 16; i++) {
      if (type == types[i]) {
        setState(() {
          userType = typesDetails[i];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (flag == false) {
      gettype();
      setState(() {
        flag = true;
      });
    }

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 30),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.purple[200],
                          minimumSize: const Size(15, 30)),
                      onPressed: () {
                        Get.to(() => const Signin());
                      },
                      child: const Icon(
                        Icons.exit_to_app,
                        size: 20,
                      )),
                  profile()
                ]),
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

  profile() {
    // function for show users data
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 50),
            Column(children: [
              Builder(builder: (context) {
                return const CircleAvatar(
                  backgroundImage: AssetImage("lib/assets/1.jpg"),
                  radius: 60,
                );
              }),
            ]),
            const SizedBox(
              width: 30,
            ),
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Divider(
          color: Colors.purple[700],
          thickness: 0.7,
          indent: 60,
          endIndent: 50,
        ),
        const SizedBox(
          height: 10,
        ),
        Card(
          elevation: 0,
          color: Colors.transparent,
          margin: const EdgeInsets.all(10.0),
          child: Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 1),
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
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  type,
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userType,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // ignore: deprecated_member_use
        RaisedButton(
          onPressed: () {},
          color: Colors.purple[100],
          child: const Text("More Details"),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
