import 'package:flutter/material.dart';
import '../utils/animations.dart';

class AnimatedFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;

  const AnimatedFloatingButton({super.key, required this.onPressed});

  @override
  _AnimatedFloatingButtonState createState() => _AnimatedFloatingButtonState();
}

class _AnimatedFloatingButtonState extends State<AnimatedFloatingButton> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleAnimation(
      controller: _controller,
      child: FloatingActionButton(
        onPressed: widget.onPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}