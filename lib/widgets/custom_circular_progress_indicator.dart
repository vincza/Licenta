import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double size;
  final double strokeWidth;
  const CustomCircularProgressIndicator(
      {Key? key, required this.size, required this.strokeWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(
          Theme.of(context).colorScheme.secondary,
        ),
        strokeWidth: strokeWidth,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
