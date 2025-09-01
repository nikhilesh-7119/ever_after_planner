import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:flutter/material.dart';

class SummaryCounters extends StatelessWidget {
  const SummaryCounters({
    super.key,
    required this.total,
    required this.yes,
    required this.no,
    required this.maybe,
    this.totalColor,
  });

  final int total;
  final int yes;
  final int no;
  final int maybe;
  final Color? totalColor;

  Widget _tile(String label, int value, Color bg, Color fg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Text('$value',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: fg)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _tile('Total', total, totalColor ?? Colors.white, Colors.black54),
        const SizedBox(width: 8),
        _tile('Yes', yes, AppColors.yes, Colors.black87),
        const SizedBox(width: 8),
        _tile('No', no, AppColors.no, Colors.black87),
        const SizedBox(width: 8),
        _tile('Maybe', maybe, AppColors.maybe, Colors.black87),
      ],
    );
  }
}
