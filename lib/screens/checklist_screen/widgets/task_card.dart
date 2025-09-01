import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/models/task_model.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleCompleted,
    required this.onEdit,
  });

  final TaskModel task;
  final ValueChanged<bool> onToggleCompleted;
  final VoidCallback onEdit;

  Color _urgencyColor(Urgency u) {
    switch (u) {
      case Urgency.high:
        return AppColors.urgencyHigh;
      case Urgency.medium:
        return AppColors.urgencyMedium;
      case Urgency.low:
        return AppColors.urgencyLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      decoration: task.completed
          ? TextDecoration.lineThrough
          : TextDecoration.none,
      decorationThickness: 2,
    );

    return Cards(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: task.completed,
            onChanged: (v) => onToggleCompleted(v ?? false),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: titleStyle),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _badge(task.category, Colors.white),
                    _inline('Last date:', task.lastDateText),
                    _pill(task.urgency.name, _urgencyColor(task.urgency)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Edit',
            icon: const Icon(Icons.edit_outlined),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: const Border.fromBorderSide(
          BorderSide(color: AppColors.border),
        ),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _pill(String text, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: const Border.fromBorderSide(
          BorderSide(color: AppColors.border),
        ),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget _inline(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
