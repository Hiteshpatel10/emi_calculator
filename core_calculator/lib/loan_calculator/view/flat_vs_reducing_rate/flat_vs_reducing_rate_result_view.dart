import 'package:core_calculator/loan_calculator/bloc/emi_calculator_cubit.dart';
import 'package:core_calculator/loan_calculator/functions/flat_vs_reducing_function.dart';
import 'package:core_utility/core_model/core_key_value_pair_model.dart';
import 'package:core_utility/extensions/currency_formatter/inr_formatter.dart';
import 'package:core_utility/extensions/num_extensions.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlatVsReducingRateResultView extends StatelessWidget {
  const FlatVsReducingRateResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flat vs Reducing Rate"),
      ),
      body: BlocBuilder<EmiCalculatorCubit, EmiCalculatorState>(
        builder: (context, state) {
          if (state is EmiFlatVsReducingSuccess) {
            return _buildSummary(context, state.emiModel);
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildSummary(BuildContext context, CoreFlatVsReducingModel state) {
    final List<CoreKeyValuePairModel<String, String, void>> inputs = [
      CoreKeyValuePairModel(key: 'Loan Amount', value: format2INR(state.flat.loanAmount)),
      CoreKeyValuePairModel(key: 'Interest Rate', value: state.flat.interestRate.toPercent()),
      CoreKeyValuePairModel(key: 'Duration', value: '${state.flat.tenure ~/ 12} Years'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Column(
        children: [
          // Loan Summary
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: CoreBoxDecoration.getBoxDecoration(
              color: CoreColors.catskillWhite,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    inputs.length,
                    (index) {
                      final item = inputs[index];

                      return Column(
                        children: [
                          Text(item.key),
                          Text(
                            item.value,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Feature
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: CoreBoxDecoration.getBoxDecoration(),
            child: RichText(
              text: TextSpan(
                text: "You will pay  ",
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: format2INR(state.interestDifference),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: CoreColors.shareGreen, fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(text: "  less with Reducing Interest Rate"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: CoreBoxDecoration.getBoxDecoration(),
            child: _buildComparison(context, state),
          ),

          const SizedBox(height: 16),

          _buildChart(context, state)
        ],
      ),
    );
  }

  Widget _buildComparison(BuildContext context, CoreFlatVsReducingModel state) {
    final List<String> headers = ["", "Flat Rate", "Reducing"];

    final headerStyle =
        Theme.of(context).textTheme.labelMedium?.copyWith(color: CoreColors.textGrey);
    final valueStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(color: CoreColors.darkJungleGreen);

    return DataTable(
      columns: List.generate(
        headers.length,
        (index) {
          return DataColumn(
            label: Text(
              headers[index],
              style: headerStyle,
            ),
          );
        },
      ),
      rows: [
        DataRow(
          cells: [
            DataCell(Text("Monthly EMI", style: headerStyle)),
            DataCell(Text(format2INR(state.flat.emi), style: valueStyle)),
            DataCell(Text(format2INR(state.reducing.emi), style: valueStyle)),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text("Total interest", style: headerStyle)),
            DataCell(Text(format2INR(state.flat.interestPaid), style: valueStyle)),
            DataCell(Text(format2INR(state.reducing.interestPaid), style: valueStyle)),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text("Total Amount", style: headerStyle)),
            DataCell(Text(format2INR(state.flat.totalRepayment), style: valueStyle)),
            DataCell(Text(format2INR(state.reducing.totalRepayment), style: valueStyle)),
          ],
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context, CoreFlatVsReducingModel state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      decoration: CoreBoxDecoration.getBoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                titlesData: const FlTitlesData(show: false),
                gridData: const FlGridData(show: false),
                borderData:   FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: state.reducing.interestPaid,
                        color: CoreColors.shareGreen,
                        width: 30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      BarChartRodData(
                        toY: state.reducing.principlePaid,
                        color: CoreColors.toryBlue,
                        width: 30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: state.flat.interestPaid,
                        color: CoreColors.shareGreen,
                        width: 30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      BarChartRodData(
                        toY: state.flat.principlePaid,
                        color: CoreColors.toryBlue,
                        width: 30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.circle,
                color: CoreColors.shareGreen,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text("Interest Paid", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: 20),
              const Icon(
                Icons.circle,
                color: CoreColors.toryBlue,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text("principle Paid", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }
}
