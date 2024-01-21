import 'package:flutter/material.dart';

class SnackBarUtils {
  static showSuccessSnackBar(
      {context,
      required String message,
      String? actionTitle,
      Color? backgroundColor = Colors.green,
      Function()? onTap}) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      action: SnackBarAction(
        label: actionTitle ?? "",
        textColor: Colors.black,
        onPressed: () {
          if (onTap != null) onTap();
        },
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showErrorSnackBar(
      {context,
      required String message,
      String? actionTitle,
      Color? backgroundColor = Colors.red,
      Function()? onTap}) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Text(
        message,
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      action: SnackBarAction(
        label: actionTitle ?? "",
        onPressed: () {
          if (onTap != null) onTap();
        },
      ),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
