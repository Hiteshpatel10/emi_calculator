import 'package:core_calculator/utils/calculator_enums.dart';
import 'package:flutter/material.dart';

typedef TenureSelectCallback = void Function(TenureType tenureType);

Widget getTenureSelector(BuildContext context, {required TenureType selectedTenure, required TenureSelectCallback onTenureChange}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            onTenureChange(TenureType.years);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: selectedTenure == TenureType.years
                ? BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(12),
                    ),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  )
                : null,
            child: const Text("Years"),
          ),
        ),
        GestureDetector(
          onTap: () {
            onTenureChange(TenureType.months);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: selectedTenure == TenureType.months
                ? BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(12),
                    ),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  )
                : null,
            child: const Text("Months"),
          ),
        ),
      ],
    ),
  );
}
