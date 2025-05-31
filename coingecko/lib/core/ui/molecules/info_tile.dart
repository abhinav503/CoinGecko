import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? trailing;
  final Widget? trailingWidget;
  final IconData? leading;
  const InfoTile({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading:
          leading != null
              ? CustomIconWidget(
                icon: leading!,
                color: AppColors.primaryIconColor,
                size: 20,
              )
              : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: AppColors.primaryTextColorLight,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing:
          trailingWidget ??
          Text(trailing ?? "", style: Theme.of(context).textTheme.titleSmall!),
    );
  }
}
