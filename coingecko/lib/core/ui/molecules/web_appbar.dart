import 'package:coingecko/core/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebAppbar extends StatelessWidget implements PreferredSizeWidget {
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
  final TextStyle? style;
  const WebAppbar({
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
    this.style,
    this.backIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation ?? 0,
      child: Container(
        height: height,
        color: backgroundColor ?? WebAppbarColors.appbarBackgroundColor,
        child: Row(
          children: [
            if (showBackButton == true)
              IconButton(
                onPressed: onPressedBack,
                icon: Icon(Icons.arrow_back),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 70.h);
}
