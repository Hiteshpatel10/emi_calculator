import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreFlatTabBar extends StatelessWidget {
  const CoreFlatTabBar({
    super.key,
    required this.tabs,
    this.isScrollable = true,
    this.controller,
    this.labelColor,
    this.indicatorColor,
    this.selectedColor,
    this.dividerColor,
    this.unselectedLabelColor,
    this.indicator,
    this.indicatorDecoration,
    this.indicatorPadding,
  });

  final List<String> tabs;
  final bool isScrollable;
  final TabController? controller;
  final Color? labelColor;
  final Color? indicatorColor;
  final Color? selectedColor;
  final Color? dividerColor;
  final Color? unselectedLabelColor;
  final bool? indicator;
  final Decoration? indicatorDecoration;
  final EdgeInsets? indicatorPadding;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabAlignment: isScrollable ? TabAlignment.start : null,
      controller: controller,
      dividerColor: dividerColor ?? Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      physics: const BouncingScrollPhysics(),
      isScrollable: isScrollable,

      padding: EdgeInsets.zero,
      indicatorColor: indicatorColor ?? CoreColors.toryBlue,
      labelColor: labelColor ?? CoreColors.toryBlue,
      indicatorPadding: indicatorPadding ?? const EdgeInsets.only(left: 4, right: 4, top: 6),
      unselectedLabelColor: unselectedLabelColor ?? CoreColors.darkJungleGreen,
      indicator: indicator == true
          ? indicatorDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selectedColor ?? CoreColors.toryBlue,
              )
          : null,
      tabs: List.generate(
        tabs.length,
        (index) {
          return Tab(text: tabs[index]);
        },
      ),
    );
  }
}
