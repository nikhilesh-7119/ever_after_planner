import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/models/task_model.dart';
import 'package:flutter/material.dart';

class TaskFormSheet extends StatefulWidget {
  const TaskFormSheet({
    super.key,
    this.initial,
    required this.onSubmit,
  });

  final TaskModel? initial; // null => add, non-null => edit
  final void Function(String title, String category, String lastDate, Urgency urgency) onSubmit;

  @override
  State<TaskFormSheet> createState() => _TaskFormSheetState();
}

class _TaskFormSheetState extends State<TaskFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final categoryCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  Urgency? picked;

  @override
  void initState() {
    super.initState();
    final t = widget.initial;
    if (t != null) {
      titleCtrl.text = t.title;
      categoryCtrl.text = t.category;
      dateCtrl.text = t.lastDateText;
      picked = t.urgency;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16, right: 16, top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.black26, borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              widget.initial == null ? 'Add task' : 'Edit task',
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              validator: (v) => (v==null || v.trim().isEmpty) ? 'Enter title' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: categoryCtrl,
              decoration: const InputDecoration(
                labelText: 'Category',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              validator: (v) => (v==null || v.trim().isEmpty) ? 'Enter category' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: dateCtrl,
              decoration: const InputDecoration(
                labelText: 'Last date (plain text)',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
              validator: (v) => (v==null || v.trim().isEmpty) ? 'Enter last date' : null,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  backgroundColor: Colors.white,
                  label: const Text('high'),
                  selected: picked == Urgency.high,
                  onSelected: (_) => setState(() => picked = Urgency.high),
                ),
                ChoiceChip(
                  backgroundColor: Colors.white,
                  label: const Text('medium'),
                  selected: picked == Urgency.medium,
                  onSelected: (_) => setState(() => picked = Urgency.medium),
                ),
                ChoiceChip(
                  backgroundColor: Colors.white,
                  label: const Text('low'),
                  selected: picked == Urgency.low,
                  onSelected: (_) => setState(() => picked = Urgency.low),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && picked != null) {
                        widget.onSubmit(
                          titleCtrl.text.trim(),
                          categoryCtrl.text.trim(),
                          dateCtrl.text.trim(),
                          picked!,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      widget.initial == null ? 'OK' : 'Save',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
