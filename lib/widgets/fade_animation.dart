import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum Prop { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation({
    Key? key,
    required this.delay,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<Prop>()
      ..add(Prop.opacity, Tween(begin: 0.0, end: 1.0),
          const Duration(milliseconds: 500))
      ..add(Prop.translateY, Tween(begin: -30.0, end: 0.0),
          const Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<Prop>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(Prop.opacity),
        child: Transform.translate(
          offset: Offset(
            0,
            animation.get(Prop.translateY),
          ),
          child: child,
        ),
      ),
    );
  }
}
