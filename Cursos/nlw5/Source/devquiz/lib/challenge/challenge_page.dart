import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: SafeArea(
            top: true,
            child: QuestionIndicatorWidget(),
          ),
          preferredSize: Size.fromHeight(60),
        ),
        body: QuizWidget(title: "O que o flutter faz em sua totalizade?"));
  }
}
