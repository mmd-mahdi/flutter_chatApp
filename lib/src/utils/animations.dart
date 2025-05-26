import 'package:flutter/material.dart';

class FadeAnimation extends StatelessWidget {
  final AnimationController controller;
  final Widget child;

  const FadeAnimation({super.key, required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: controller, curve: Curves.easeIn),
      child: child,
    );
  }
}

class SlideAnimation extends StatelessWidget {
  final AnimationController controller;
  final Widget child;

  const SlideAnimation({super.key, required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut)),
      child: child,
    );
  }
}

class ScaleAnimation extends StatelessWidget {
  final AnimationController controller;
  final Widget child;

  const ScaleAnimation({super.key, required this.controller, required this.child});

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: CurvedAnimation(parent: controller, curve: Curves.elasticOut),
      child: child,
    );
  }
}