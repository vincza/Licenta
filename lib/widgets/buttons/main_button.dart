import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool busy;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;

  const MainButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.busy,
    required this.color,
    this.margin,
    this.fontSize,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        margin: margin,
        height: 42,
        duration: const Duration(milliseconds: 300),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: color),
        child: !busy
            ? Text(
                text,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontSize: fontSize ?? 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
              )
            : const CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ),
    );
  }
}
