import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quizzler/quizeBrain.dart';

void main() => runApp(Quizzler());
QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int score=0;
  List<Icon> scoreKeeper = [];
  void restart(){
    Alert(
      context: context,
      //  type: AlertType.,
      title: "Done",
      desc: "Your score is $score.",
      buttons: [
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }
  void chk(){
    if(quizBrain.isFinished()==true){
      //quizBrain.alartEnd();
      restart();
      //Alert(context: context, title: "Done", desc: 'Tour score is $score.').show();
      quizBrain.resetQno();
      scoreKeeper.clear();
    }
  }
  void checkAnswers(bool userPick){
    bool correctAns =quizBrain.getAns() ;
    setState(
          () {
        quizBrain.nextQuestion();
        quizBrain.isFinished();

      },
    );
    //print(qusNum);
    //Checks For Correct answers
    if(correctAns == userPick){
      print('correct');
      scoreKeeper.add(Icon(Icons.check,color: Colors.green,),);
      score++;
    }
    else{
      print('Incorrect answer');
      scoreKeeper.add(Icon(Icons.close,color: Colors.red,),);
    }
  }
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
                quizBrain.getQustions(),
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
                //The user picked true.
                checkAnswers(true);
                chk();
              },
            ),
          ),
        ),
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
                //The user picked false.
                checkAnswers(false);
                chk();
              },
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}