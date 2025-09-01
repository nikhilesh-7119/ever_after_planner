// Input Card

import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';

class BudgetInputCard extends StatelessWidget {
  const BudgetInputCard({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.accent,
    required this.border,
  });
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Color accent,border;

  @override
  Widget build(BuildContext context) {
    return Cards(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.calculate_outlined,
                color: Color.fromARGB(255, 240, 143, 143),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                'Total Wedding Budget',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 36),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '1000000',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:  BorderSide(
                        color: border,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:  BorderSide(
                        color: border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: accent.withOpacity(
                          0.5,
                        ),
                      ),
                    ),
                  ),
                  onChanged: onChanged,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(
                  Icons.currency_rupee,
                  color: Colors.black54,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your total wedding budget in rupees',
            style: TextStyle(color: Color.fromARGB(196, 0, 0, 0), fontSize: 12,fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}


