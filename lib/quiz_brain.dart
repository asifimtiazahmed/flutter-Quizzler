import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _score = 0;
  List <Question> _questionBank = [
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', true),
    Question('Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        'No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        'In London, UKm if you happen to die in the House of Parliament, you are technically entitled to a state duneral, because the building is considered too sacred a place.',
        true),
    Question(
        'The loudest sound produced by any animal is 188decibels. That animal is the African Elephant.',
        false),
    Question(
        'The total surface area of two human lungs is approximately 70 square meters.',
        true),
    Question('Google was originally called \"Backrub\".', true),
    Question(
        'Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a dog.',
        true),
    Question(
        'In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true)
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }

  bool isFinished() {
    bool areAllQestionsFinished = false;
    if (_questionNumber < _questionBank.length - 1) {
      areAllQestionsFinished = false;
     // print('returning false, still more questions left');
    }
    else {
      areAllQestionsFinished = true;
    //  print('returning true, all questions are done');
    }
    return areAllQestionsFinished;
  }

  void reset(){
    _questionNumber = 0;
    _score=0;
  }

  void scoreSetter(){
    _score++;
  }

  int scoreGetter(){
    return _score;
  }
int getNoOfQuestions(){
    return _questionBank.length;
}

}