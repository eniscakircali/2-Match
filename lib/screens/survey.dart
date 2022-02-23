// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mbti_match/screens/homepage.dart';
import 'package:mbti_match/services/functions.dart';
import 'package:survey_kit/survey_kit.dart';
import 'package:get/get.dart';

class Survey extends StatefulWidget {
  const Survey({Key? key}) : super(key: key);

  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  // ignore: prefer_typing_uninitialized_variables
  var type;
  var name = Get.arguments;

  int first_a_counter = 0;
  int first_b_counter = 0;
  int second_a_counter = 0;
  int second_b_counter = 0;
  int third_a_counter = 0;
  int third_b_counter = 0;
  int fourth_a_counter = 0;
  int fourth_b_counter = 0;
  String Result = "";

  bool flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: FutureBuilder<Task>(
            future: getSampleTask(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data != null) {
                final task = snapshot.data!;
                return SurveyKit(
                  onResult: (SurveyResult result) {
                    print(result.finishReason);
                  },
                  task: task,
                  themeData: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.fromSwatch(
                      primarySwatch: Colors.cyan,
                    ).copyWith(
                      onPrimary: Colors.white,
                    ),
                    primaryColor: Colors.cyan,
                    backgroundColor: Colors.white,
                    appBarTheme: const AppBarTheme(
                      color: Colors.white,
                      iconTheme: IconThemeData(
                        color: Colors.cyan,
                      ),
                      // ignore: deprecated_member_use
                      textTheme: TextTheme(
                        button: TextStyle(
                          color: Colors.cyan,
                        ),
                      ),
                    ),
                    iconTheme: const IconThemeData(
                      color: Colors.cyan,
                    ),
                    outlinedButtonTheme: OutlinedButtonThemeData(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                          const Size(150.0, 60.0),
                        ),
                        side: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return const BorderSide(
                                color: Colors.grey,
                              );
                            }
                            return const BorderSide(
                              color: Colors.cyan,
                            );
                          },
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        textStyle: MaterialStateProperty.resolveWith(
                          (Set<MaterialState> state) {
                            if (state.contains(MaterialState.disabled)) {
                              return Theme.of(context)
                                  .textTheme
                                  .button
                                  ?.copyWith(
                                    color: Colors.grey,
                                  );
                            }
                            return Theme.of(context).textTheme.button?.copyWith(
                                  color: Colors.cyan,
                                );
                          },
                        ),
                      ),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.button?.copyWith(
                                color: Colors.cyan,
                              ),
                        ),
                      ),
                    ),
                  ),
                );
              }
              return const CircularProgressIndicator.adaptive();
            },
          ),
        ),
      ),
    );
  }

  Future<Task> getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to the\nMBTI\n Personality Test',
          text:
              'Get ready for a bunch of confusing questions! It could take few minutes',
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          //1
          title: 'At a party do you:',
          text:
              'a. Interact with many, including strangers \nb. Interact with a few, known to you ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //2
          title: 'Common sense is: ',
          text: 'a. rarely questionable \nb. frequently questionable ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //3
          title: 'Are you more interested in: ',
          text: 'a. What is actual \nb. What is possible ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //4
          title: ' Which appeals to you more: ',
          text:
              'a. Consistency of thought \nb. Harmonious human relationships ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //5
          title: 'In approaching others is your inclination to be somewhat: ',
          text: 'a. Objective \nb. Personal ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //6
          title: 'Do you prefer to work: ',
          text: 'a. To deadlines \nb. Just “whenever” ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //7
          title: 'Are you more comfortable: ',
          text: 'a. After a decision \nb. Before a decision ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //1
          title: 'In phoning do you: ',
          text:
              'a. Rarely question that it will all be said \nb. Rehearse what you’ll say ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //2
          title: 'Facts:  ',
          text: 'a. “Speak for themselves” \nb. Illustrate principles ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //3
          title: 'Children often do not: ',
          text:
              'a. make themselves useful enough \nb. exercise their fantasy enough ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //4
          title: 'Which is more satisfying:',
          text:
              'a. to discuss an issue thoroughly \nb. to arrive at agreement on an issue ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //5
          title: ' Is it worse to be: ',
          text: 'a. unjust \nb. merciless ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //6
          title: 'Which is more admirable: ',
          text:
              'a. the ability to organize and be methodical \nb. the ability to adapt and make do ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //7
          title: 'Do you feel better about: ',
          text: 'a. having purchased \nb. having the option to buy ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //1
          title: ' Does new and non-routine interaction with others: ',
          text: 'a. stimulate and energize you \nb. tax your reserves ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //2
          title: 'Do you prize more in yourself: ',
          text: 'a. a strong sense of reality \nb. a vivid imagination ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //3
          title: 'Is it harder for you to:',
          text: 'a. identify with others \nb. utilize others ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //4
          title: 'Which seems the greater error: ',
          text: 'a. to be too passionate \nb. to be too objective ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //5
          title: 'Are you inclined more to be: ',
          text: 'a. fair-minded \nb. sympathetic ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //6
          title: 'Is it preferable mostly to:',
          text: 'a. make sure things are arranged \nb. just let things happen ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //7
          title: 'Do you put more value on: ',
          text: 'a. infinite \nb. open-minded ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          //
          title: 'All Done!',
          text: "Let's see the results",
          isOptional: true,
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        )
      ],
    );

    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[21].stepIdentifier,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "A":
              evaluate();
              setState(() {
                Get.to(() => const HomePage(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(seconds: 1),
                    arguments: name);
              });
              break;
            case "B":
              evaluate();
              setState(() {
                Get.to(() => const HomePage(),
                    transition: Transition.rightToLeft,
                    duration: const Duration(seconds: 1),
                    arguments: name);
              });
              break;
            default:
              evaluate();
              Get.to(() => const HomePage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(seconds: 1),
                  arguments: name);
          }
        },
      ),
    );
    for (var i = 1; i <= 21; i++) {
      // evaluating results
      task.addNavigationRule(
          forTriggerStepIdentifier: task.steps[i].stepIdentifier,
          navigationRule:
              ConditionalNavigationRule(resultToStepIdentifierMapper: (input) {
            switch (input) {
              case "A":
                if (i % 7 == 1) {
                  first_a_counter++;
                } else if (i % 7 == 2) {
                  second_a_counter++;
                } else if (i % 7 == 3) {
                  second_a_counter++;
                } else if (i % 7 == 4) {
                  third_a_counter++;
                } else if (i % 7 == 5) {
                  third_a_counter++;
                } else if (i % 7 == 6) {
                  fourth_a_counter++;
                } else if (i % 7 == 0) {
                  fourth_a_counter++;
                }
                break;
              case "B":
                if (i % 7 == 1) {
                  first_b_counter++;
                } else if (i % 7 == 2) {
                  second_b_counter++;
                } else if (i % 7 == 3) {
                  second_b_counter++;
                } else if (i % 7 == 4) {
                  third_b_counter++;
                } else if (i % 7 == 5) {
                  third_b_counter++;
                } else if (i % 7 == 6) {
                  fourth_b_counter++;
                } else if (i % 7 == 0) {
                  fourth_b_counter++;
                }
                break;
            }
          }));
    }

    return Future.value(task);
  }

  Future<Task> getJsonTask() async {
    final taskJson = await rootBundle.loadString('assets/example_json.json');
    final taskMap = json.decode(taskJson);
    return Task.fromJson(taskMap);
  }

  evaluate() async {
    if (first_a_counter >= first_b_counter) {
      Result += "E";
    } else {
      Result += "I";
    }
    if (second_a_counter >= second_b_counter) {
      Result += "S";
    } else {
      Result += "N";
    }
    if (third_a_counter >= third_b_counter) {
      Result += "T";
    } else {
      Result += "F";
    }
    if (fourth_a_counter >= fourth_b_counter) {
      Result += "J";
    } else {
      Result += "P";
    }
    type = Result;

    await Functions().updateType(name, type).then((name) {
      //function call for updating user type.
      if (name.data['success']) {
        Get.to(() => const HomePage(),
            transition: Transition.rightToLeft,
            duration: const Duration(seconds: 1),
            arguments: name);
      }
    });
  }
}
