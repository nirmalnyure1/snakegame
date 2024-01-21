import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:snakegame/snack_bar_utils.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _checkInApp(BuildContext context) async {
    InAppUpdate.checkForUpdate().then((value) async {
      if (value.immediateUpdateAllowed) {
        final AppUpdateResult result =
            await InAppUpdate.performImmediateUpdate();
        if (context.mounted) {
          if (result == AppUpdateResult.inAppUpdateFailed) {
            SnackBarUtils.showErrorSnackBar(
                context: context, message: "Update failed");
          } else if (result == AppUpdateResult.success) {
            SnackBarUtils.showSuccessSnackBar(
                context: context, message: "Update success");
          }
        }
      }
    });
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 500)).whenComplete(() {
      // SnackBarUtils.showSuccessSnackBar(
      //     context: NavigationService.context, message: "success");
      _checkInApp(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Snake',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: "Quicksand",
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
