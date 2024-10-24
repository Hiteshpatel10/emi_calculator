import 'package:core_calculator/utils/calculator_enums.dart';
import 'package:core_utility/core_mode.dart';
import 'package:core_utility/navigation/core_navigator.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

typedef InterestRateCallback = void Function(double rate);

Widget getInterestRateSelector(
  BuildContext context, {
  required List<CoreKeyValuePairModel<String, String, double>> interestRateList,
  required InterestRateCallback onRateSelect,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    child: GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  interestRateList.length,
                  (index) {
                    final item = interestRateList[index];

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            CoreNavigator.pop();
                            onRateSelect(item.extra!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 160,
                                  child: Text(
                                    item.key,
                                    style: Theme.of(context).textTheme.titleSmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Text(
                                  item.value,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const Spacer(),

                                 Icon(Icons.keyboard_arrow_right_outlined, color: Theme.of(context).primaryColor,)
                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: CoreBoxDecoration.getBoxDecoration(
          removeShadow: true,
          color: Colors.transparent,
          border: Border.all(color: Theme.of(context).primaryColor),
          addBorder: true,
          borderRadius: 16,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          "Help 💡",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
        ),
      ),
    ),
  );
}
