import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:flutter/material.dart';

class RangeFilters extends StatelessWidget {
  const RangeFilters({
    super.key,
    required this.budget,
    required this.onBudgetChanged,
    required this.capacity,
    required this.onCapacityChanged,
  });

  // Budget in lakhs, e.g., 5..20
  final RangeValues budget;
  final ValueChanged<RangeValues> onBudgetChanged;

  // Capacity, e.g., 50..1000
  final RangeValues capacity;
  final ValueChanged<RangeValues> onCapacityChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(
          BorderSide(color: AppColors.border),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Budget Range',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          RangeSlider(
            values: budget,
            min: 5, // ₹5L
            max: 20, // ₹20L
            divisions: 15,
            labels: RangeLabels(
              '₹${budget.start.toInt()}L',
              '₹${budget.end.toInt()}L',
            ),
            activeColor: AppColors.accent.withOpacity(0.6),
            inactiveColor: AppColors.accent.withOpacity(0.2),
            onChanged: onBudgetChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [Text('₹5L'), Text('₹20L')],
          ),
          const SizedBox(height: 10),
          const Text('Capacity', style: TextStyle(fontWeight: FontWeight.w700)),
          RangeSlider(
            values: capacity,
            min: 50,
            max: 1000,
            divisions: 19, // steps of ~50
            labels: RangeLabels(
              '${capacity.start.toInt()} guests',
              '${capacity.end.toInt()} guests',
            ),
            activeColor: AppColors.accent.withOpacity(0.6),
            inactiveColor: AppColors.accent.withOpacity(0.2),
            onChanged: onCapacityChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${capacity.start.toInt()} guests'),
              Text('${capacity.end.toInt()} guests'),
            ],
          ),
        ],
      ),
    );
  }
}
