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
          title: 'Are you more: ',
          text:
              'a. Realistic than speculative  \nb. Speculative than realistic ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Is it worse to: ',
          text: 'a. Have your “head in the clouds”\nb. Be “in a rut',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more impressed by: ',
          text: 'a. Principles \nb. Emotions ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are more drawn toward the:',
          text: 'a. Convincing\nb. Touching ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you prefer to work: ',
          text: 'a. To deadlines \nb. Just “whenever” ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you tend to choose: ',
          text: 'a. Rather carefully \nb. Somewhat impulsively',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'At parties do you: ',
          text:
              'a. Stay late, with increasing energy \nb. Leave early with decreased energy ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more attracted to: ',
          text: 'a. Sensible people \nb. Imaginative people ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more interested in: ',
          text: 'a. What is actual \nb. What is possible ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'In judging others are you more swayed by:',
          text: 'a. Laws than circumstances \nb. Circumstances than laws ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'In approaching others is your inclination to be somewhat: ',
          text: 'a. Objective \nb. Personal ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more:  ',
          text: 'a. Punctual \nb. Leisurely ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Does it bother you more having things: ',
          text: 'a. Incomplete \nb. Completed ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'In your social groups do you: ',
          text:
              'a. Keep abreast of other’s happenings\nb. Get behind on the news ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'In doing ordinary things are you more likely to: ',
          text: 'a. Do it the usual way \nb. Do it your own way ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Writers should: ',
          text:
              'a. “Say what they mean and mean what they say” \nb. Express things more by use of analogy ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
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
          title: ' Are you more comfortable in making: ',
          text: 'a. Logical judgments \nb. Value judgments ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you want things: ',
          text: 'a. Settled and decided \nb. Unsettled and undecided ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Would you say you are more: ',
          text: 'a. Serious and determined \nb. Easy-going ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
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
          title: 'Facts:  ',
          text: 'a. “Speak for themselves” \nb. Illustrate principles ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are visionaries: ',
          text: 'a. somewhat annoying \nb. rather fascinating ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more often: ',
          text: 'a. a cool-headed person \nb. a warm-hearted person ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: ' Is it worse to be: ',
          text: 'a. unjust \nb. merciless ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Should one usually let events occur:',
          text:
              'a. by careful selection and choice \nb. randomly and by chance ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you feel better about: ',
          text: 'a. having purchased \nb. having the option to buy ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'In company do you: ',
          text: 'a. initiate conversation  \nb. wait to be approached  ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Common sense is: ',
          text: 'a. rarely questionable \nb. frequently questionable ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
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
          title: 'In making decisions do you feel more comfortable with: ',
          text: 'a. standards \nb. feelings ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more:  ',
          text: 'a. firm than gentle \nb. gentle than firm ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
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
          title: 'Do you put more value on: ',
          text: 'a. infinite \nb. open-minded ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: ' Does new and non-routine interaction with others: ',
          text: 'a. stimulate and energize you \nb. tax your reserves ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more frequently: ',
          text: 'a. a practical sort of person \nb. a fanciful sort of person ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more likely to: ',
          text: 'a. see how others are useful \nb. see how others see ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
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
          title: 'Which rules you more: ',
          text: 'a. your head \nb. your heart ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more comfortable with work that is: ',
          text: 'a. contracted \nb. done on a casual basis ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you tend to look for: ',
          text: 'a. the orderly \nb. whatever turns up ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you prefer: ',
          text:
              'a. many friends with brief contact \nb. a few friends with more lengthy contact ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: ' Do you go more by: ',
          text: 'a. facts \nb. principles  ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more interested in: ',
          text: 'a. production and distribution \nb. design and research  ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Which is more of a compliment: ',
          text:
              'a. “There is a very logical person.” \nb. “There is a very sentimental person.” ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you value in yourself more that you are:',
          text: 'a. unwavering \nb. devoted ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you more often prefer the:',
          text:
              'a. final and unalterable statement \nb. tentative and preliminary statement ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more comfortable: ',
          text: 'a. after a decision \nb. before a decision ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you: ',
          text:
              'a. speak easily and at length with strangers \nb. find little to say to strangers ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more likely to trust your: ',
          text: 'a. experience \nb. hunch ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you feel: ',
          text:
              'a. more practical than ingenious \nb. more ingenious than practical ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: ' Which person is more to be complimented - one of: ',
          text: 'a. clear reason \nb. strong feeling ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you inclined more to be: ',
          text: 'a. fair-minded \nb. sympathetic ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Is it preferable mostly to:',
          text: 'a. make sure things are arranged \nb. just let things happen ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: ' In relationships should most things be: ',
          text: 'a. re-negotiable \nb. random and circumstantial ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'When the phone rings do you: ',
          text:
              'a. hasten to get to it first \nb. hope someone else will answer ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you prize more in yourself: ',
          text: 'a. a strong sense of reality \nb. a vivid imagination ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you drawn more to: ',
          text: 'a. fundamentals \nb. overtones ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Which seems the greater error: ',
          text: 'a. to be too passionate \nb. to be too objective ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you see yourself as basically:',
          text: 'a. hard-headed \nb. soft-hearted ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Which situation appeals to you more: ',
          text:
              'a. the structured and scheduled \nb. the unstructured and unscheduled ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you a person that is more: ',
          text: 'a. routinized than whimsical \nb. whimsical than routinized ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Are you more inclined to be: ',
          text: 'a. easy to approach \nb. somewhat reserved ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'In writings do you prefer:',
          text: 'a. the more literal \nb. the more figurative ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Is it harder for you to:',
          text: 'a. identify with others \nb. utilize others ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Which do you wish more for yourself: ',
          text: 'a. clarity of reason \nb. strength of compassion ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Which is the greater fault: ',
          text: 'a. being indiscriminate \nb. being critical ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you prefer the: ',
          text: 'a. planned event \nb. unplanned event ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Do you tend to be more:',
          text:
              'a. deliberate than spontaneous \nb. spontaneous than deliberate ',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Last Step Before Type Evaluation',
          answerFormat: const BooleanAnswerFormat(
            positiveAnswer: 'A',
            negativeAnswer: 'B',
            result: BooleanResult.POSITIVE,
          ),
        )
      ],
    );

    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[70].stepIdentifier,
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
    for (var i = 1; i <= 70; i++) {
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
