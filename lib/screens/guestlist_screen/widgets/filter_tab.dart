import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:flutter/material.dart';

enum FilterTab { all, yes, no, maybe, pending }

class FilterStrip extends StatelessWidget {
  const FilterStrip({
    super.key,
    required this.active,
    required this.onChanged,
  });

  final FilterTab active;
  final ValueChanged<FilterTab> onChanged;

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: AppColors.accent.withOpacity(0.18),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? Colors.black : Colors.black87,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _chip('All', active == FilterTab.all, () => onChanged(FilterTab.all)),
          _chip('Yes', active == FilterTab.yes, () => onChanged(FilterTab.yes)),
          _chip('No', active == FilterTab.no, () => onChanged(FilterTab.no)),
          _chip('Maybe', active == FilterTab.maybe, () => onChanged(FilterTab.maybe)),
          _chip('Pending', active == FilterTab.pending, () => onChanged(FilterTab.pending)),
        ],
      ),
    );
  }
}
