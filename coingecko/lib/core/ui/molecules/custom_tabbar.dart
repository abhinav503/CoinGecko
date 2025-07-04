import 'package:coingecko/core/colors/app_colors.dart';
import 'package:coingecko/core/ui/atoms/custom_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:collection/collection.dart';

class CustomTabbar extends StatefulWidget {
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
  final Function(int)? onTap;
  final bool isScrollable;
  final TabAlignment tabAlignment;
  final bool showIndicator;
  final List<IconData> icons;
  const CustomTabbar({
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
    this.onTap,
    this.showIndicator = true,
    this.icons = const [],
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
      height: widget.height,
      child: TabBar(
        isScrollable: widget.isScrollable,
        controller: widget.tabController,
        onTap: (index) {
          widget.onTap?.call(index);
        },
        tabs:
            widget.tabs
                .mapIndexed(
                  (index, tab) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        key: Key("custom_tabbar_text_$index"),
                        tab,
                        style:
                            widget.textStyle ??
                            Theme.of(context).textTheme.bodySmall,
                      ),
                      if (widget.showIndicator)
                        CustomIconWidget(
                          icon: widget.icons[index],
                          color: widget.selectedColor ?? AppColors.primaryColor,
                          size: 20,
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
            const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
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
