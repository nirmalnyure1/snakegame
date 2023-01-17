import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:snakegame/control_buttons.dart';
import 'package:snakegame/enum.dart';
import 'package:snakegame/show_dialog.dart';
import 'package:snakegame/snake_piece.dart';
import 'package:snakegame/utils.dart';

import 'dynamic_message.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<Offset> listOfSnakePosition = [];
  int snakeLenght = 5;
  int step = 20;
  Direction direction = Direction.right;

  SnakePiece? food;
  Offset? foodPosition;

  double screenWidth = 0;
  double screenHeight = 0;
  int lowerBoundX = 0;
  int upperBoundX = 0;
  int lowerBoundY = 0;
  int upperBoundY = 0;
  Timer? timer;
  double speed = 1;
  int score = 0;
  // AssetsAudioPlayer? _audioPlayer;
  AudioPlayer? audioPlayer;
  String eatFoodAudio = "audio/eatfood.mp3";
  String strikeAudio = "audio/strike.mp3";
  AssetSource? strikeAssetSource;
  AssetSource? eatfoodAssetSource;

  Direction getRandomDirection() {
    int random = Random().nextInt(2);
    return Direction.values[random];
  }

  Offset getRandomPositionWithinRange() {
    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;
    return Offset(Utils.roundToNearestTens(posX, step).toDouble(),
        Utils.roundToNearestTens(posY, step).toDouble());
  }

  bool boundriesCollisionDetect(
      {required Offset position, required Offset nextPosition}) {
    if (position.dx >= upperBoundX && direction == Direction.right) {
      return true;
    } else if (position.dx <= lowerBoundX && direction == Direction.left) {
      return true;
    } else if (position.dy >= upperBoundY && direction == Direction.down) {
      return true;
    } else if (position.dy <= lowerBoundY && direction == Direction.up) {
      return true;
    }
    if (listOfSnakePosition.contains(nextPosition)) return true;
    return false;
  }

  ownCollisonDetect(Offset nextPosition) {}

//draw snake /
  void drawSnake() async {
    if (listOfSnakePosition.isEmpty) {
      listOfSnakePosition.add(getRandomPositionWithinRange());
    }

    while (snakeLenght > listOfSnakePosition.length) {
      listOfSnakePosition
          .add(listOfSnakePosition[listOfSnakePosition.length - 1]);
    }
    //illusion
    for (var i = listOfSnakePosition.length - 1; i > 0; i--) {
      listOfSnakePosition[i] = listOfSnakePosition[i - 1];
    }

    listOfSnakePosition[0] =
        await getNextPositionOfSnake(listOfSnakePosition[0]);
  }

  void drawFood() {
    foodPosition ??= getRandomPositionWithinRange();
    food = SnakePiece(
      posX: foodPosition!.dx.toInt(),
      posY: foodPosition!.dy.toInt(),
      size: step,
      color: const Color.fromARGB(255, 1, 225, 255),
      isAnimated: true,
    );

    if (listOfSnakePosition.isNotEmpty &&
        foodPosition == listOfSnakePosition[0]) {
      snakeLenght++;
      speed = speed + 0.25;
      score += 5;
      changeSnakeSpeed();
      foodPosition = getRandomPositionWithinRange();

      playSound(eatfoodAssetSource!);
    }
  }

  Future<Offset> getNextPositionOfSnake(Offset position) async {
    Offset nextPosition = const Offset(0, 0);

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }

    if (boundriesCollisionDetect(
            position: position, nextPosition: nextPosition) ==
        true) {
      if (timer != null && timer!.isActive) timer!.cancel();
      Score.saveScore(score);
      String message = await Score.getDynamicMessage(score);
      playSound(strikeAssetSource!);
      await Future.delayed(
        const Duration(milliseconds: 1000),
        () => showGameOverDialog(context, onPressed: () async {
          Navigator.of(context).pop();
          restart();
        }, score: score, message: message),
      );
      return nextPosition;
    }

    return nextPosition;
  }

  void changeSnakeSpeed() {
    if (timer != null && timer!.isActive) timer!.cancel();
    timer = Timer.periodic(Duration(milliseconds: 200 ~/ speed), (timer) {
      setState(() {});
    });
  }

  void restart() async {
    score = 0;
    snakeLenght = 5;
    listOfSnakePosition = [];
    direction = getRandomDirection();
    speed = 1;
    changeSnakeSpeed();
  }

  List<SnakePiece> getSnakePiece() {
    List<SnakePiece> listSnakePiece = [];
    drawSnake();
    drawFood();

    for (int i = 0; i < snakeLenght; i++) {
      if (i >= listOfSnakePosition.length) {
        continue;
      }
      listSnakePiece.add(SnakePiece(
        posX: listOfSnakePosition[i].dx.toInt(),
        posY: listOfSnakePosition[i].dy.toInt(),
        color: i == 1 ? Colors.green.shade700 : Colors.green,
        size: step,
        key: ValueKey(i),
      ));
    }

    return listSnakePiece;
  }

  Widget getGameControlButtons() {
    return ControlButtons(
      onPressed: (Direction newDirection) {
        if (direction == newDirection) return;
        if (direction == Direction.up && newDirection == Direction.down) return;
        if (direction == Direction.down && newDirection == Direction.up) return;
        if (direction == Direction.left && newDirection == Direction.right) {
          return;
        }
        if (direction == Direction.right && newDirection == Direction.left) {
          return;
        }

        Future.delayed(const Duration(milliseconds: 50)).whenComplete(() {
          direction = newDirection;
        });
        debugPrint("hello");
      },
    );
  }

  Widget showScore() {
    return Positioned(
      top: 50.0,
      right: 40.0,
      child: Text(
        "Score:  ${score.toString()} ",
        style: const TextStyle(fontSize: 24.0, color: Colors.black26),
      ),
    );
  }

  Widget getPlayAreaBorder() {
    return Positioned(
      top: lowerBoundY.toDouble(),
      left: lowerBoundX.toDouble(),
      child: Container(
        width: (upperBoundX - lowerBoundX + step).toDouble(),
        height: (upperBoundY - lowerBoundY + step).toDouble(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green.shade100),
      ),
    );
  }

  disposeAudio() {
    if (audioPlayer != null) {
      audioPlayer!.stop();
      audioPlayer!.dispose();
      audioPlayer = null;
    }
  }

  playSound(AssetSource assetSource) async {
    disposeAudio();
    audioPlayer = AudioPlayer();
    await audioPlayer!.play(assetSource);
  }

  @override
  void initState() {
    super.initState();
    eatfoodAssetSource = AssetSource(eatFoodAudio);
    strikeAssetSource = AssetSource(strikeAudio);
    restart();
  }

  @override
  void dispose() {
    disposeAudio();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    lowerBoundX = step;
    lowerBoundY = step;
    upperBoundX = Utils.roundToNearestTens(screenWidth.toInt() - step, step);
    upperBoundY = Utils.roundToNearestTens(screenHeight.toInt() - step, step);

    return Scaffold(
      body: SafeArea(
        top: true,
        left: false,
        right: false,
        bottom: false,
        child: Container(
          color: Colors.red.shade100,
          child: Stack(
            children: [
              Container(color: Colors.green.shade200),
              getPlayAreaBorder(),
              Stack(
                children: getSnakePiece(),
              ),
              getGameControlButtons(),
              if (food != null) food!,
              showScore(),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
