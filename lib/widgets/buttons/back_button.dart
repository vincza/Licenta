import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onTap;
  final Color? color;
  final IconData? icon;
  const CustomBackButton({Key? key, required this.onTap, this.color, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Icon(
          icon ?? Icons.arrow_back_ios_new,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
