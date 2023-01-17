import 'package:flutter/material.dart';
import 'package:snakegame/home_page.dart';

import 'custom_button.dart';

void showGameOverDialog(context,
    {required Function() onPressed,
    required int score,
    required String message}) {
  showDialog(
    barrierColor: Colors.green.shade100.withOpacity(0.5),
    barrierDismissible: false,
    useSafeArea: true,
    context: context,
    builder: (ctx) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: Colors.green.shade300,
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.white,
                width: 3.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Game Over",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "$message. Your score is ${score.toString()} .",
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            CustomElevatedButton(
              name: 'Back to Home',
              hPadding: 10,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false);
              },
              color: Colors.green.shade300,
              elevation: 0,
            ),
            const SizedBox(width: 5),
            CustomElevatedButton(
              name: 'Restart',
              hPadding: 10,
              onPressed: onPressed,
            ),
          ],
        ),
      );
    },
  );
}
