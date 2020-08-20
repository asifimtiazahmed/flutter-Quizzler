import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //added from an example
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

 List <Icon> scoreKeeper = [ ]; //Use angle brackets to enable data type (typesafe)

 void checkAnswer(bool userPickedAnswer){
   bool correctAns = quizBrain.getAnswer(); //referring to the List of question_book, and getting the index of questionNumber and then getting the string property of questionAnswer
   setState(() {
     if (quizBrain.isFinished()) {
       //RFlutter Alert button widget below
       int scoreRecvd = quizBrain.scoreGetter();
       int totalScore = quizBrain.getNoOfQuestions();
       Alert(
         context: context,
         type: AlertType.success,
         title: "CONGRATULATIONS",
         desc: "You have completed the Quiz. You got $scoreRecvd/$totalScore Correct!",
         buttons: [
           DialogButton(
             child: Text(
               "RESET",
               style: TextStyle(color: Colors.white, fontSize: 20),
             ),
             onPressed: () => Navigator.pop(context),
             width: 120,
           )
         ],
       ).show();
       //resetting the question Number
       quizBrain.reset();
       //Emptying out the scorekeeper.
       scoreKeeper.clear();
     } else {
       if (userPickedAnswer == correctAns) {
         //print('User got it right');
         scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
         quizBrain.scoreSetter(); //adds score as player gets it right
       } else {
         //print('User got it wrong');
         //The user picked false.
         scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
       }
       quizBrain.nextQuestion();
     }
   });
 }

 //TODO: Add an API here to get list
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ), //True Button
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ), // False Button
        Row(
          children: scoreKeeper,
        ),

      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
