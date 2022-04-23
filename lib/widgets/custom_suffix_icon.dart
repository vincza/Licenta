import 'package:flutter/material.dart';

class CustomSuffixIcon extends StatelessWidget {
  final Color? containerColor;
  final void Function()? onPressed;
  final Widget icon;
  const CustomSuffixIcon(
      {Key? key,
      required this.onPressed,
      this.containerColor,
      required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: GestureDetector(
        child: icon,
        onTap: onPressed,
      ),
    );
  }
}
