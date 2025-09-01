import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/dummy_data/seed_checkList.dart';
import 'package:ever_after_planner/models/task_model.dart';
import 'package:ever_after_planner/screens/checklist_screen/widgets/check_filters.dart';
import 'package:ever_after_planner/screens/checklist_screen/widgets/task_card.dart';
import 'package:ever_after_planner/screens/checklist_screen/widgets/task_form_sheet.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final List<TaskModel> allTasks = [];
  ChecklistFilter active = ChecklistFilter.all;

  @override
  void initState() {
    super.initState();
    allTasks.addAll(seedTasks);
  }

  List<TaskModel> get _active => allTasks.where((t) => !t.completed).toList();
  List<TaskModel> get _done => allTasks.where((t) => t.completed).toList();

  List<TaskModel> _visible() {
    switch (active) {
      case ChecklistFilter.all:
        return List<TaskModel>.from(allTasks);
      case ChecklistFilter.active:
        return _active;
      case ChecklistFilter.done:
        return _done;
    }
  }

  void _toggleCompleted(TaskModel t, bool value) {
    setState(() {
      t.completed = value;
    });
  }

  void _addTask(String title, String category, String date, Urgency urgency) {
    setState(() {
      allTasks.add(TaskModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: title,
        category: category,
        lastDateText: date,
        urgency: urgency,
        completed: false,
      ));
    });
  }

  void _editTask(TaskModel t, String title, String category, String date, Urgency urgency) {
    setState(() {
      t.title = title;
      t.category = category;
      t.lastDateText = date;
      t.urgency = urgency;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible();
    final total = allTasks.length;
    final completed = _done.length;

    return Scaffold(
      backgroundColor: AppColors.bg,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Color.fromARGB(255, 255, 247, 253),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => FractionallySizedBox(
              heightFactor: 0.6,
              child: TaskFormSheet(
                onSubmit: (title, category, date, urgency) {
                  _addTask(title, category, date, urgency);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0), // custom top padding, no SafeArea
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                const Text('Checklist', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                '$completed of $total tasks completed',
                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600,fontSize: 20  ),
              ),
            ),
            const SizedBox(height: 12),
            CheckFilters(
              active: active,
              onChanged: (f) => setState(() => active = f),
            ),
            // const SizedBox(height: 12),
            Expanded(
              child: visible.isEmpty
                  ? const _EmptyState()
                  : ListView.separated(
                      itemCount: visible.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final t = visible[i];
                        return TaskCard(
                          task: t,
                          onToggleCompleted: (v) => _toggleCompleted(t, v),
                          onEdit: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Color.fromARGB(255, 255, 247, 253),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                              ),
                              builder: (_) => FractionallySizedBox(
                                heightFactor: 0.6,
                                child: TaskFormSheet(
                                  initial: t,
                                  onSubmit: (title, category, date, urgency) {
                                    _editTask(t, title, category, date, urgency);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Cards(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.task_alt, size: 40, color: Colors.black38),
            SizedBox(height: 8),
            Text('No tasks', style: TextStyle(fontWeight: FontWeight.w700)),
            SizedBox(height: 4),
            Text('Use + to add your first task', style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
