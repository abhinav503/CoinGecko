import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.icon,
    required this.color,
    required this.size,
  });
  final IconData icon;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return HugeIcon(icon: icon, color: color, size: size);
  }
}
