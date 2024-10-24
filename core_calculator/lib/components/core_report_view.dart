import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

class CoreReportView extends StatefulWidget {
  const CoreReportView({
    super.key,
    required this.monthlyReportWidget,
    required this.yearlyReportWidget,
  });
  final Widget monthlyReportWidget;
  final Widget yearlyReportWidget;

  @override
  State<CoreReportView> createState() => _CoreReportViewState();
}

class _CoreReportViewState extends State<CoreReportView> {
  bool isYearlyReport = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio(
              value: true,
              groupValue: isYearlyReport,
              onChanged: (value) {
                setState(() {
                  isYearlyReport = true;
                });
              },
            ),
            Text(
              "Yearly Report",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: CoreColors.darkJungleGreen),
            ),
            const SizedBox(width: 12),
            Radio(
              value: false,
              groupValue: isYearlyReport,
              onChanged: (value) {
                setState(() {
                  isYearlyReport = false;
                });
              },
            ),
            Text(
              "Monthly Report",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: CoreColors.darkJungleGreen),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (isYearlyReport) widget.yearlyReportWidget else widget.monthlyReportWidget
      ],
    );
  }
}

class ExpandableList extends StatefulWidget {
  const ExpandableList({
    super.key,
    required this.items,
    this.title,
  });

  final List<Widget> items;
  final List<String>? title;

  @override
  State<ExpandableList> createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.items.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedIndex == index) {
                _selectedIndex = -1;
                return;
              }
              _selectedIndex = index;
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            width: MediaQuery.of(context).size.width,
            decoration: CoreBoxDecoration.getBoxDecoration(
              borderRadius: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title?[index] ?? "Year ${index + 1}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: CoreColors.darkJungleGreen),
                    ),
                    AnimatedRotation(
                      turns: _selectedIndex == index ? 0.5 : 0,
                      duration: const Duration(milliseconds: 400),
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: CoreColors.toryBlue,
                      ),
                    )
                  ],
                ),
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 400),
                  firstChild: widget.items[index],
                  secondChild: Container(),
                  crossFadeState: _selectedIndex == index
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
