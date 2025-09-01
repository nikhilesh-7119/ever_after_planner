// Sliders
import 'package:ever_after_planner/models/category_model.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';

class CategorySlidersCard extends StatelessWidget {
  const CategorySlidersCard({
    super.key,
    required this.categories,
    required this.totalBudget,
    required this.onChanged,
    required this.formatCurrency,
  });

  final List<CategoryModel> categories;
  final int totalBudget;
  final void Function(int index, double newPct) onChanged;
  final String Function(num) formatCurrency;

  @override
  Widget build(BuildContext context) {
    return Cards(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Adjust Categories',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          ...List.generate(categories.length, (i) {
            final c = categories[i];
            final amount = (totalBudget * c.percentage) / 100;
            return Padding(
              padding: EdgeInsets.only(
                bottom: i == categories.length - 1 ? 0 : 14,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(c.icon, style: const TextStyle(fontSize: 18)),
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
                  Slider(
                    value: c.percentage.clamp(0, 60),
                    min: 0,
                    max: 60,
                    divisions: 60,
                    label: '${c.percentage.toStringAsFixed(0)}%',
                    onChanged: (v) => onChanged(i, v),
                    activeColor: Color.fromARGB(255, 240, 143, 143),
                    inactiveColor: Color.fromARGB(255, 240, 143, 143)
                        .withOpacity(0.25),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}