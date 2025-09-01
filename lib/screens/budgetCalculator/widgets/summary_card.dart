// Summary
import 'package:ever_after_planner/models/category_model.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.categories,
    required this.totalBudget,
    required this.formatCurrency, required this.border, required this.accent,
  });

  final List<CategoryModel> categories;
  final int totalBudget;
  final String Function(num) formatCurrency;
  final Color border,accent;

  @override
  Widget build(BuildContext context) {
    return Cards(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Summary', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...categories.map((c) {
            final amount = (totalBudget * c.percentage) / 100;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border:  Border.fromBorderSide(
                  BorderSide(color: border),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: c.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      c.name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        formatCurrency(amount),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${c.percentage.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
           Divider(color: const Color.fromARGB(255, 76, 75, 75),thickness: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              Text(
                formatCurrency(
                  categories.fold<double>(
                    0,
                    (s, c) => s + (totalBudget * c.percentage / 100),
                  ),
                ),
                style:  TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: accent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

