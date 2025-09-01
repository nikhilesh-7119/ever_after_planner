import 'package:ever_after_planner/models/category_model.dart';
import 'package:ever_after_planner/models/preset_model.dart';
import 'package:ever_after_planner/screens/budgetCalculator/widgets/breakdown_chart_card.dart';
import 'package:ever_after_planner/screens/budgetCalculator/widgets/budget_header.dart';
import 'package:ever_after_planner/screens/budgetCalculator/widgets/budget_input_card.dart';
import 'package:ever_after_planner/screens/budgetCalculator/widgets/category_slider_card.dart';
import 'package:ever_after_planner/screens/budgetCalculator/widgets/preset_card.dart';
import 'package:ever_after_planner/screens/budgetCalculator/widgets/summary_card.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BudgetCalculatorScreen extends StatefulWidget {
  const BudgetCalculatorScreen({super.key, this.onBack});
  final VoidCallback? onBack;

  @override
  State<BudgetCalculatorScreen> createState() => _BudgetCalculatorScreenState();
}

class _BudgetCalculatorScreenState extends State<BudgetCalculatorScreen> {
  final TextEditingController totalBudgetCtrl = TextEditingController(
    text: '1000000',
  );

  final List<CategoryModel> categories = [
    CategoryModel(
      name: 'Venue',
      percentage: 40,
      color: const Color(0xFFF6DCE0),
      icon: '🏛️',
    ),
    CategoryModel(
      name: 'Catering',
      percentage: 30,
      color: const Color(0xFFC9A464),
      icon: '🍽️',
    ),
    CategoryModel(
      name: 'Photography',
      percentage: 15,
      color: const Color(0xFFE8D5C4),
      icon: '📸',
    ),
    CategoryModel(
      name: 'Décor',
      percentage: 10,
      color: const Color(0xFFF2E8D5),
      icon: '🌸',
    ),
    CategoryModel(
      name: 'Other',
      percentage: 5,
      color: const Color(0xFFFDF8F3),
      icon: '✨',
    ),
  ];

  final presets = const [
    PresetModel(
      name: 'Traditional',
      venue: 45,
      catering: 25,
      photography: 15,
      decor: 10,
      other: 5,
    ),
    PresetModel(
      name: 'Modern',
      venue: 35,
      catering: 35,
      photography: 20,
      decor: 5,
      other: 5,
    ),
    PresetModel(
      name: 'Luxury',
      venue: 50,
      catering: 25,
      photography: 15,
      decor: 8,
      other: 2,
    ),
  ];

  static const bg = Color.fromARGB(255, 236, 233, 233);
  static const accent = Color.fromARGB(255, 240, 143, 143);
  static const border = Color(0xFFEAE6E2);

  int get totalBudget {
    final v = int.tryParse(totalBudgetCtrl.text.replaceAll(',', '')) ?? 0;
    return v < 0 ? 0 : v;
  }

  String formatCurrency(num amount) {
    if (amount >= 100000) return '₹${(amount / 100000).toStringAsFixed(1)}L';
    if (amount >= 1000) return '₹${(amount / 1000).toStringAsFixed(0)}K';
    final f = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );
    return f.format(amount);
  }

  void applyPreset(PresetModel p) {
    setState(() {
      categories[0].percentage = p.venue;
      categories[1].percentage = p.catering;
      categories[2].percentage = p.photography;
      categories[3].percentage = p.decor;
      categories[4].percentage = p.other;
    });
  }

  // Core redistribution logic: keep total = 100 when one slider changes
  // void updateCategoryPercentage(int index, double newPct) {
  //   final list = categories.map((c) => c.copy()).toList();
  //   final old = list[index].percentage;
  //   final diff = newPct - old;

  //   list[index].percentage = newPct.clamp(0, 100);

  //   final others = List<int>.generate(list.length, (i) => i)..remove(index);
  //   final totalOthers = others.fold<double>(0, (s, i) => s + list[i].percentage);

  //   if (totalOthers > 0) {
  //     for (final i in others) {
  //       final ratio = list[i].percentage / totalOthers;
  //       list[i].percentage = (list[i].percentage - diff * ratio).clamp(0, 100);
  //     }
  //   }

  //   // Normalize to 100 and round to tenths to avoid long decimals
  //   final sum = list.fold<double>(0, (s, c) => s + c.percentage);
  //   final factor = 100 / sum;
  //   for (final c in list) {
  //     c.percentage = (c.percentage * factor);
  //   }
  //   for (final c in list) {
  //     c.percentage = double.parse(c.percentage.toStringAsFixed(1));
  //   }

  //   setState(() {
  //     for (var i = 0; i < categories.length; i++) {
  //       categories[i].percentage = list[i].percentage;
  //     }
  //   });
  // }

  void updateCategoryPercentage(int index, double newPct) {
    // 1) Bound the requested value to slider range first
    newPct = newPct.clamp(0.0, 60.0);

    // Work on a copy
    final list = categories.map((c) => c.copy()).toList();
    final old = list[index].percentage;
    final diff = newPct - old;

    list[index].percentage = newPct;

    // 2) Distribute the difference only among others > 0 (when shrinking) or all others (when growing)
    final othersIdx = List<int>.generate(list.length, (i) => i)..remove(index);
    double pool = 0;
    for (final i in othersIdx) pool += list[i].percentage;

    if (pool > 0) {
      for (final i in othersIdx) {
        final ratio = list[i].percentage / pool;
        list[i].percentage = (list[i].percentage - diff * ratio);
      }
    }

    // 3) Normalize to sum = 100
    final sum = list.fold<double>(0, (s, c) => s + c.percentage);
    if (sum != 100) {
      final factor = 100 / sum;
      for (final c in list) {
        c.percentage *= factor;
      }
    }

    // 4) Snap to one decimal and clamp to slider range
    for (final c in list) {
      c.percentage = double.parse(c.percentage.toStringAsFixed(1));
      c.percentage = c.percentage.clamp(0.0, 60.0);
    }

    // 5) If rounding pushed total off 100, fix the largest segment to absorb remainder
    final total = list.fold<double>(0, (s, c) => s + c.percentage);
    final remainder = double.parse((100.0 - total).toStringAsFixed(1));
    if (remainder.abs() >= 0.1) {
      // adjust the largest slice that is not the one at bounds
      int j = 0;
      for (int i = 1; i < list.length; i++) {
        if (list[i].percentage > list[j].percentage) j = i;
      }
      list[j].percentage = (list[j].percentage + remainder).clamp(0.0, 60.0);
    }

    setState(() {
      for (var i = 0; i < categories.length; i++) {
        categories[i].percentage = list[i].percentage;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = (MediaQuery.of(context).size.width / 390).clamp(0.9, 1.2);

    return Scaffold(
      backgroundColor: bg,
      body: SingleChildScrollView(
        // padding: ,
        child: Column(
          children: [
            BudgetHeader(
              onBack: () {
                Get.back();
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16 * s, 0 * s, 16 * s, 24 * s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(height: 6 * s),
                  BudgetInputCard(
                    controller: totalBudgetCtrl,
                    onChanged: (_) => setState(() {}),
                    accent: _BudgetCalculatorScreenState.accent,
                    border: _BudgetCalculatorScreenState.border,
                  ),
                  SizedBox(height: 12 * s),

                  PresetCard(
                    presets: presets,
                    onApply: applyPreset,
                    border: _BudgetCalculatorScreenState.border,
                  ),
                  SizedBox(height: 12 * s),

                  if (totalBudget > 0)
                    BreakdownChartCard(
                      categories: categories,
                      totalBudget: totalBudget,
                      formatCurrency: formatCurrency,
                      s: s,
                    ),
                  if (totalBudget > 0) SizedBox(height: 12 * s),

                  CategorySlidersCard(
                    categories: categories,
                    totalBudget: totalBudget,
                    onChanged: updateCategoryPercentage,
                    formatCurrency: formatCurrency,
                  ),
                  SizedBox(height: 12 * s),

                  if (totalBudget > 0)
                    SummaryCard(
                      categories: categories,
                      totalBudget: totalBudget,
                      formatCurrency: formatCurrency,
                      border: _BudgetCalculatorScreenState.border,
                      accent: _BudgetCalculatorScreenState.accent,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





