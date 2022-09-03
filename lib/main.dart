import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var engNumber = 4;
  var firstImage = 2;
  var secondImage = 4;
  var thirdImage = 6;
  int score = 0;

  List myanmarNumList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  // var a;
  // var b;
  // var c;
  var showAnswer = '';

  void getRandom() {
    myanmarNumList.shuffle();
    firstImage = myanmarNumList[0];
    secondImage = myanmarNumList[1];
    thirdImage = myanmarNumList[2];
    print(firstImage);
    print(secondImage);
    print(thirdImage);
    var answerList = [firstImage, secondImage, thirdImage];
    answerList.shuffle();
    engNumber = answerList[0];
  }

  void chechAnswer(int cardNumber) async {
    if (engNumber == cardNumber) {
      showAnswer = "Your ans is correct.";
      score = score + 10;
    } else {
      showAnswer = 'Your ans is wrong.';
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('score', score);
    setState(() {});
  }

  getScores() async {
    final prefs = await SharedPreferences.getInstance();
    score = prefs.getInt('score')!;
    setState(() {});
  }

  _imageWidget(image) {
    return InkWell(
      onTap: () {
        setState(() {
          chechAnswer(image);
          getRandom();
        });
      },
      child: Image.asset(
        'images/$image.png',
        height: 150,
      ),
    );
  }

  @override
  void initState() {
    getScores();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Learn Myanmar Number")),
      body: Center(
          child: Column(
        children: [
          Text("Select the number $engNumber"),
          _imageWidget(firstImage),
          _imageWidget(secondImage),
          _imageWidget(thirdImage),
          Text(showAnswer),
          Text("Your score is $score")
        ],
      )),
    );
  }
}