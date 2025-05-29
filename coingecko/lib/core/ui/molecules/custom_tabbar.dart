import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabbar extends StatefulWidget {
  final List<String> tabs;
  final Function(int) onTabChanged;
  final TabController tabController;
  final int initialIndex;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? indicatorColor;
  final double? fontSize;

  const CustomTabbar({
    super.key,
    required this.tabs,
    required this.onTabChanged,
    required this.tabController,
    this.initialIndex = 0,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.fontSize,
  });

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      widget.onTabChanged(widget.tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: TabBar(
        isScrollable: true,
        controller: widget.tabController,
        tabs:
            widget.tabs
                .map(
                  (tab) =>
                      Text(tab, style: Theme.of(context).textTheme.titleSmall),
                )
                .toList(),
        labelColor: widget.selectedColor ?? Theme.of(context).primaryColor,
        unselectedLabelColor: widget.unselectedColor ?? Colors.grey,
        indicatorColor: widget.indicatorColor ?? Theme.of(context).primaryColor,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: TextStyle(
          fontSize: widget.fontSize ?? 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: widget.fontSize ?? 16,
          fontWeight: FontWeight.w400,
        ),
        indicator: BoxDecoration(
          color: widget.indicatorColor ?? Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        indicatorPadding: EdgeInsets.symmetric(vertical: 4.w),
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        splashFactory: NoSplash.splashFactory,
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    );
  }
}
