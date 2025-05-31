import 'package:coingecko/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryTextButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const PrimaryTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        "\n$text",
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}
