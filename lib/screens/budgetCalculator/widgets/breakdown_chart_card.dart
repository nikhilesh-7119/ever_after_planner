// Chart
import 'package:ever_after_planner/models/category_model.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BreakdownChartCard extends StatelessWidget {
  const BreakdownChartCard({
    super.key,
    required this.categories,
    required this.totalBudget,
    required this.formatCurrency,required this.s,
  });

  final List<CategoryModel> categories;
  final int totalBudget;
  final String Function(num) formatCurrency;
  final double s;

  @override
  Widget build(BuildContext context) {
    final sections = categories
        .map(
          (c) => PieChartSectionData(
            color: c.color,
            value: c.percentage,
            title: '',
            radius: 70 * s,
          ),
        )
        .toList();

    return Cards(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Budget Breakdown',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 200 * s,
              child: PieChart(
                PieChartData(
                  sections: sections,
                  sectionsSpace: 2,
                  centerSpaceRadius: 48,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}