import 'package:flutter/material.dart';
import 'package:snakegame/custom_button.dart';
import 'package:snakegame/game_page.dart';
import 'package:snakegame/share_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int topScore = 0;

  @override
  void initState() {
    getScore();
    super.initState();
  }

  getScore() async {
    topScore = await SharedPref.getScore();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("powered by Subit"),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.green.shade100,
              Colors.green.shade200,
              Colors.green.shade400,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Top score: $topScore",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Welcome to snake game",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GamePage()),
                  );
                },
                name: "Play ",
                hPadding: 100,
                vPadding: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
