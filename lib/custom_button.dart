import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  final IconData? prefixIcon;
  final bool hasIcon;
  final double hPadding;
  final double vPadding;
  final Color color;
  final double elevation;
  final double borderRadius;
  final double iconSize;

  const CustomElevatedButton(
      {Key? key,
      required this.onPressed,
      required this.name,
      this.prefixIcon,
      this.hasIcon = false,
      this.hPadding = 0.0,
      this.vPadding = 10,
      this.color = Colors.green,
      this.elevation = 2,
      this.borderRadius = 10,
      this.iconSize = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          backgroundColor: color,
          elevation: elevation,
          padding: EdgeInsets.symmetric(vertical: vPadding, horizontal: hPadding),
        ),
        onPressed: () {
          onPressed();
        },
        child: hasIcon
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    prefixIcon,
                    size: iconSize,
                    color: Colors.white,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
