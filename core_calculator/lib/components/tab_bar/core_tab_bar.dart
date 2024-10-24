import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreTabBar extends StatelessWidget {
  final List<String> tabList;
  final bool isScrollable;
  final bool hasInnerShadow;
  final bool transformTo2d;
  final double height;
  final Color? selectedColor;
  final TabController? tabController;
  final double borderRadius;
  final double fontSize;
  final double horizontalPadding;
  final double verticalPadding;
  final Border? border;
  const CoreTabBar({
    Key? key,
    required this.tabList,
    this.isScrollable = false,
    this.hasInnerShadow = true,
    this.transformTo2d = false,
    this.height = 45,
    this.tabController,
    this.selectedColor,
    this.borderRadius = 32,
    this.fontSize = 13,
    this.horizontalPadding = 0,
    this.verticalPadding = 0, this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      height: height,
      decoration: BoxDecoration(
        color: transformTo2d ? Colors.transparent : Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: hasInnerShadow ? Colors.transparent : Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            border: transformTo2d == true ? border ?? Border.all(color: CoreColors.lightGrey) : null,
            boxShadow: transformTo2d == true
                ? []
                : [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.35),
                      spreadRadius: 0.0,
                      blurRadius: 0.0,
                      offset: const Offset(0, 0),
                    ),
                    if (hasInnerShadow)
                      const BoxShadow(
                        color: Colors.white,
                        spreadRadius: -2.0,
                        blurRadius: 10.0,
                      ),
                  ],
          ),
          child: TabBar(
            dividerColor: Colors.transparent,
            isScrollable: isScrollable,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            tabAlignment: isScrollable ? TabAlignment.start : null,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle:   Theme.of(context).textTheme.bodyMedium,
            padding: const EdgeInsets.all(6),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: selectedColor ?? CoreColors.toryBlue,
              boxShadow: transformTo2d == true
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 0.0,
                        blurRadius: 4.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            controller: tabController,
            tabs: tabList.map(
              (tab) {
                return Tab(
                  child: Text(
                    tab,

                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
