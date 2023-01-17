import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;

  const CustomRoundedButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: onPressed,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.shade300,
          ),
          child: Icon(
            icon,
            size: 20,
          ),
        ),
      ),
    );
  }
}
