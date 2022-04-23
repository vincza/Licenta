import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {Key? key, required this.title, required this.onTap, required this.color})
      : super(key: key);
  final Function() onTap;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 230,
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              blurRadius: 8,
              spreadRadius: 5,
              color: Theme.of(context).colorScheme.background.withOpacity(0.2),
            ),
          ],
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}
