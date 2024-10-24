import 'package:core_calculator/components/core_report_builder.dart';
import 'package:core_calculator/components/core_report_view.dart';
import 'package:core_calculator/components/tab_bar/core_flat_tab_bar.dart';
import 'package:core_calculator/loan_calculator/bloc/emi_calculator_cubit.dart';
import 'package:core_calculator/loan_calculator/functions/emi_function.dart';
import 'package:core_utility/core_mode.dart';
import 'package:core_utility/extensions/currency_formatter/inr_formatter.dart';
import 'package:core_utility/extensions/num_extensions.dart';
import 'package:core_utility/theme/core_box_decoration.dart';
import 'package:core_utility/theme/core_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmiResultView extends StatelessWidget {
  const EmiResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("EMI Calculator")),
      body: BlocBuilder<EmiCalculatorCubit, EmiCalculatorState>(
        builder: (context, state) {
          if (state is EmiCalculatorSuccess) {
            return DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  const CoreFlatTabBar(
                    isScrollable: false,
                    tabs: ['Summary', 'Graph', 'Report'],
                  ),
                  Flexible(
                    child: TabBarView(
                      children: [
                        _buildSummary(context, state.emiModel),
                        _buildGraph(context, state.emiModel),
                        _buildReport(context, state.emiModel),
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }

  Widget _buildSummary(BuildContext context, CoreEMIModel state) {
    final List<CoreKeyValuePairModel<String, String, void>> inputs = [
      CoreKeyValuePairModel(key: 'Loan Amount', value: format2INR(state.loanAmount)),
      CoreKeyValuePairModel(key: 'Interest Rate', value: state.interestRate.toPercent()),
      CoreKeyValuePairModel(key: 'Duration', value: '${state.tenure} Years'),
    ];

    final List<CoreKeyValuePairModel<String, String, void>> details = [
      CoreKeyValuePairModel(key: 'Total Interest Paid', value: format2INR(state.interestPaid)),
      CoreKeyValuePairModel(key: 'Total Repayment', value: format2INR(state.totalRepayment)),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: CoreBoxDecoration.getBoxDecoration(
              color: CoreColors.hintOfGreen,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Monthly Repayment (EMI)",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  format2INR(state.emi),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
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
          const SizedBox(height: 20),
          ...List.generate(
            details.length,
            (index) {
              final item = details[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: CoreBoxDecoration.getBoxDecoration(),
                child: Row(
                  children: [
                    Text(
                      item.key,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text(
                      item.value,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildGraph(BuildContext context, CoreEMIModel state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 64,
                sections: [
                  PieChartSectionData(
                    radius: 60,
                    color: CoreColors.toryBlue20,
                    value: state.interestPaid,
                    title: format2INR(state.interestPaid),
                  ),
                  PieChartSectionData(
                    radius: 60,
                    color: CoreColors.lightSage,
                    value: state.principlePaid,
                    title: format2INR(state.principlePaid),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.circle,
                color: CoreColors.lightSage,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text("Principle Paid", style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(width: 20),
              const Icon(
                Icons.circle,
                color: CoreColors.toryBlue20,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text("Interest Paid", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReport(BuildContext context, CoreEMIModel state) {
    final today = DateTime.now();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CoreReportView(
        monthlyReportWidget: ExpandableList(
          title: List.generate(
            state.report.monthlyReport.length,
            (index) => today.add(Duration(days: 365 * index)).year.toString(),
          ),
          items: List.generate(state.report.monthlyReport.length ?? 0, (index) {
            final monthlyReport = state.report.monthlyReport[index];

            return CoreReportBuilder<CoreEMIReportModel>(
              report: monthlyReport,
              itemBuilder: (context, index, investValueModel) {
                return [
                  Text((index + 1).toString()),
                  Text(format2INR(investValueModel.principalRepayment)),
                  Text(format2INR(investValueModel.interest)),
                  Text(format2INR(investValueModel.principleOutstanding)),
                ];
              },
              itemCount: monthlyReport.length ?? 0,
              columns: const [
                "Month",
                "Principle\nPaid",
                "Interest\nPaid",
                "Balance",
              ],
            );
          }),
        ),
        yearlyReportWidget: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: MediaQuery.of(context).size.width,
          decoration: CoreBoxDecoration.getBoxDecoration(
            borderRadius: 12,
          ),
          child: CoreReportBuilder<CoreEMIReportModel>(
            report: state.report.yearlyReport,
            itemBuilder: (context, index, investValueModel) {
              return [
                Text((index + 1).toString()),
                Text(format2INR(investValueModel.principalRepayment)),
                Text(format2INR(investValueModel.interest)),
                Text(format2INR(investValueModel.principleOutstanding)),
              ];
            },
            itemCount: state.report.yearlyReport.length,
            columns: const [
              "Year",
              "Principle\nPaid",
              "Interest\nPaid",
              "Balance",
            ],
          ),
        ),
      ),
    );
  }
}
