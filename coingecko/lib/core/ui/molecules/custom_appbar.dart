import 'package:coingecko/core/colors/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  final double? elevation;
  final VoidCallback? onPressedBack;
  final Color? backgroundColor;
  final String title;
  final bool? showBackButton;
  final List<Widget>? actions;
  final bool? showFilter;
  final String? actionIcon;
  final VoidCallback? onTapActionItem;
  final String? backIconPath;
  final Color? backIconColor;
  final EdgeInsets? padding;
  final Widget? mainWidget;
  const CustomAppbar({
    super.key,
    this.height,
    this.onPressedBack,
    this.backgroundColor,
    required this.title,
    this.showBackButton = true,
    this.actions,
    this.showFilter = true,
    this.actionIcon,
    this.onTapActionItem,
    this.backIconPath,
    this.elevation,
    this.padding,
    this.backIconColor,
    this.mainWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 0,
      child: Container(
        padding: kIsWeb ? null : const EdgeInsets.only(top: kToolbarHeight),
        height: height,
        color: backgroundColor ?? AppColors.primaryColorLight,
        child: Row(
          children: [
            if (showBackButton == true)
              IconButton(
                onPressed: onPressedBack,
                icon: const Icon(Icons.arrow_back),
              ),
            if (mainWidget != null) Expanded(child: mainWidget!),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70.h);
}
