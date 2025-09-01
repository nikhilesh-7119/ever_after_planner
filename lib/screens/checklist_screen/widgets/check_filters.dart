import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:flutter/material.dart';

enum ChecklistFilter { all, active, done }

class CheckFilters extends StatelessWidget {
  const CheckFilters({
    super.key,
    required this.active,
    required this.onChanged,
  });

  final ChecklistFilter active;
  final ValueChanged<ChecklistFilter> onChanged;

  Widget _btn(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        backgroundColor: Colors.white,
        selectedColor: AppColors.accent.withOpacity(0.18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _btn('All', active == ChecklistFilter.all, () => onChanged(ChecklistFilter.all)),
        _btn('Active', active == ChecklistFilter.active, () => onChanged(ChecklistFilter.active)),
        _btn('Done', active == ChecklistFilter.done, () => onChanged(ChecklistFilter.done)),
      ],
    );
  }
}
