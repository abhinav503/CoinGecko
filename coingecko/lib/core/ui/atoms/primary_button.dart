import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.textColor,
    this.fontSize,
    this.height,
    this.width,
    this.radius,
    this.textStyle,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Colors.yellow,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 4),
        ),
      ),

      child: Text(
        text,
        style:
            textStyle ??
            TextStyle(
              color: textColor ?? Colors.black,
              fontSize: fontSize ?? 16,
            ),
      ),
    );
  }
}
