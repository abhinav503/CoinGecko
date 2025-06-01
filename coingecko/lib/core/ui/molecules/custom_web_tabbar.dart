import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:collection/collection.dart';

class CustomWebTabbar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabChanged;
  final TabController tabController;
  final int initialIndex;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final TextStyle? textStyle;
  final Decoration? indicator;
  final EdgeInsets? indicatorPadding;
  final double height;
  final bool isScrollable;
  final TabAlignment tabAlignment;
  final Color? backgroundColor;
  final bool showIndicator;
  final Function(int)? onTap;
  final double? tabWidth;
  const CustomWebTabbar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.tabController,
    this.initialIndex = 0,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.textStyle,
    this.indicator,
    this.height = 32,
    this.isScrollable = true,
    this.tabAlignment = TabAlignment.start,
    this.indicatorPadding,
    this.backgroundColor,
    this.showIndicator = true,
    this.onTap,
    this.tabWidth,
  });

  @override
  State<CustomWebTabbar> createState() => _CustomWebTabbarState();
}

class _CustomWebTabbarState extends State<CustomWebTabbar> {
  List<IconData> icons = [];
  @override
  void initState() {
    super.initState();
    icons = [
      HugeIcons.strokeRoundedArrowDown02,
      HugeIcons.strokeRoundedArrowDown02,
    ];
    widget.tabController.addListener(() {
      widget.onTabChanged(widget.tabController.index);
    });
  }

  rotateIcon(index) {
    setState(() {
      if (icons[index] == HugeIcons.strokeRoundedArrowDown02) {
        icons[index] = HugeIcons.strokeRoundedArrowUp02;
      } else {
        icons[index] = HugeIcons.strokeRoundedArrowDown02;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: TabBar(
        isScrollable: widget.isScrollable,
        controller: widget.tabController,
        onTap: (index) {
          widget.onTap?.call(index);
          rotateIcon(index);
        },
        tabs:
            widget.tabs
                .mapIndexed(
                  (index, tab) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: widget.tabWidth,
                        child: Text(
                          tab,
                          style:
                              widget.textStyle ??
                              Theme.of(context).textTheme.titleSmall,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      if (widget.showIndicator)
                        CustomIconWidget(
                          icon: icons[index],
                          color: widget.selectedColor ?? AppColors.primaryColor,
                          size: 16,
                        ),
                    ],
                  ),
                )
                .toList(),
        labelColor: widget.selectedColor ?? AppColors.primaryColor,
        unselectedLabelColor: widget.unselectedColor ?? Colors.grey,
        indicatorColor: widget.indicatorColor ?? AppColors.primaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: widget.indicator,
        indicatorPadding:
            widget.indicatorPadding ??
            EdgeInsets.symmetric(vertical: 4.w, horizontal: 10.w),
        tabAlignment: widget.tabAlignment,
        dividerColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
