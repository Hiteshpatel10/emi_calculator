import 'package:core_utility/theme/core_colors.dart';
import 'package:flutter/material.dart';

typedef IndexedRowBuilder<T> = List<Widget> Function(BuildContext context, int index, T item);

class CoreReportBuilder<T> extends StatelessWidget {
  const CoreReportBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.columns,
    required this.report,
  });

  final IndexedRowBuilder<T> itemBuilder;
  final int itemCount;
  final List<String> columns;
  final List<T> report;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        columns: List.generate(columns.length, (index) {
          return DataColumn(
            label: Text(
              columns[index],
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: CoreColors.boulder),
            ),
          );
        }),
        rows: List.generate(itemCount, (index) {
          final item = itemBuilder(context, index, report[index]);
          return DataRow(
            cells: List.generate(item.length, (index) {
              return DataCell(item[index]);
            }),
          );
        }),
      ),
    );
  }
}
