import 'package:coingecko/core/colors/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryChip extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;
  final double? width;
  const PrimaryChip({
    super.key,
    required this.onTap,
    required this.text,
    required this.isSelected,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      child: Container(
        // width: width,
        padding:
            !kIsWeb
                ? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h)
                : EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style:
              kIsWeb
                  ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isSelected ? AppColors.primaryColor : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  )
                  : Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? AppColors.primaryColor : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
        ),
      ),
    );
  }
}
