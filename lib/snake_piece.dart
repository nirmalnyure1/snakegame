import 'package:flutter/material.dart';

class SnakePiece extends StatefulWidget {
  final int posX, posY;
  final int size;
  final Color color;
  final bool isAnimated;
  const SnakePiece({
    super.key,
    this.posX = 0,
    this.posY = 0,
    this.size = 0,
    this.color = Colors.white,
    this.isAnimated = false,
  });

  @override
  State<SnakePiece> createState() => _SnakePieceState();
}

class _SnakePieceState extends State<SnakePiece>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.1,
      upperBound: 1.0,
      duration: const Duration(milliseconds: 600),
    );
    super.initState();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.posX.toDouble(),
      top: widget.posY.toDouble(),
      child: Opacity(
        opacity: widget.isAnimated ? _animationController.value : 1.0,
        child: Container(
          width: widget.size.toDouble(),
          height: widget.size.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
            border: Border.all(
                color: widget.isAnimated ? Colors.transparent : Colors.white,
                width: 2.0),
          ),
        ),
      ),
    );
  }
}
