import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color color;
  final Color textColor;

  const MButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.black,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: textColor),
        ),
      ),
    );
  }
}
