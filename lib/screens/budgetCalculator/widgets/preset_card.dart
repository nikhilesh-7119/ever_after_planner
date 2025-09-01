
// Presets
import 'package:ever_after_planner/models/preset_model.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';

class PresetCard extends StatelessWidget {
  const PresetCard({super.key, required this.presets, required this.onApply, required this.border});
  final List<PresetModel> presets;
  final Function(PresetModel) onApply;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return Cards(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Presets',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: presets
                .map(
                  (p) => OutlinedButton(
                    onPressed: () => onApply(p),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: border,
                      ),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    child: Text(p.name,style: TextStyle(fontSize: 16),),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}