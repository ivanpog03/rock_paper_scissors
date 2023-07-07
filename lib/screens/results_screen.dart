import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rock_paper_scisor_game/screens/main_screen.dart';
import 'package:rock_paper_scisor_game/utilis/game.dart';
import 'package:rock_paper_scisor_game/widgets/button.dart';
import 'package:flutter/services.dart';


class GameScreen extends StatefulWidget {
  GameScreen(this.gameChoice, {Key? key}) : super(key: key);
  GameChoice gameChoice;
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  /* Generating random choice */
  String? randomChoice() {
    Random random = new Random();
    int robotChoiceIndex = random.nextInt(3);
    return Game.choices[robotChoiceIndex];
  }

  @override
  Widget build(BuildContext context) {
    String robotChoice = randomChoice()!;
    String? robotChoicePath;
    switch (robotChoice) {
      case "Rock":
        robotChoicePath = "assets/rock_btn.png";
        break;
      case "Paper":
        robotChoicePath = "assets/paper_btn.png";
        break;
      case "Scisors":
        robotChoicePath = "assets/scisor_btn.png";
        break;
      default:
    }
    String? player_choice;
    switch (widget.gameChoice.type) {
      case "Rock":
        player_choice = "assets/rock_btn.png";
        break;
      case "Paper":
        player_choice = "assets/paper_btn.png";
        break;
      case "Scisors":
        player_choice = "assets/scisor_btn.png";
        break;
      default:
    }
    if (GameChoice.gameRules[widget.gameChoice.type]![robotChoice] ==
        "You Win") {
      setState(() {
        Game.gameScore++;
        
      });
    }
    double btnWidth = MediaQuery.of(context).size.width / 2 - 40;

    return Scaffold(
 backgroundColor: GameChoice.gameRules[widget.gameChoice.type]![robotChoice] == "You Win"
      ? Color.fromARGB(255, 121, 255, 161) // Red background if you win
      : Color.fromARGB(255, 255, 118, 118), // Default background color
          
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5.0),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "SCORE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${Game.gameScore}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            /* Setting the Game play pad */
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: "${widget.gameChoice.type}",
                      child: gameBtn(() {}, player_choice!, btnWidth - 20),
                    ),
                    Text(
                      "VS",
                      style: TextStyle(color: Colors.white, fontSize: 26.0),
                    ),
                    AnimatedOpacity(
                      opacity: 1,
                      duration: Duration(seconds: 3),
                      child: gameBtn(() {}, robotChoicePath!, btnWidth - 20),
                    )
                  ],
                ),
              ),
            ),
            Text(
              "${GameChoice.gameRules[widget.gameChoice.type]![robotChoice]}",
              style: TextStyle(color: Colors.white, fontSize: 36.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                padding: EdgeInsets.all(24.0),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ));
                },
                shape: StadiumBorder(),
                fillColor: Colors.white,
                child: Text(
                  "Play Again",
                  style: TextStyle(
                      color: Color(0xFF060A47),
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            
          ],
        ),
      ),
    );
  }
}
