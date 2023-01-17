import 'package:flutter/material.dart';

import 'custom_rounded_button.dart';
import 'enum.dart';

class ControlButtons extends StatelessWidget {
  final void Function(Direction direction) onPressed;

  const ControlButtons({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 45.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                CustomRoundedButton(
                  icon: Icons.arrow_left,
                  onPressed: () {
                    onPressed(Direction.left);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                CustomRoundedButton(
                  icon: Icons.arrow_drop_up_sharp,
                  onPressed: () {
                    onPressed(Direction.up);
                  },
                ),
                const SizedBox(
                  height: 75.0,
                ),
                CustomRoundedButton(
                  icon: Icons.arrow_drop_down_sharp,
                  onPressed: () {
                    onPressed(Direction.down);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CustomRoundedButton(
                  icon: Icons.arrow_right,
                  onPressed: () {
                    onPressed(Direction.right);
                  },
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
