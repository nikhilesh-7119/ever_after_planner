// Header
import 'package:flutter/material.dart';

class BudgetHeader extends StatelessWidget {
  const BudgetHeader({super.key, this.onBack});
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        children: [
          IconButton(padding: EdgeInsets.all(0),onPressed: onBack, icon: const Icon(Icons.arrow_back)),
          // const Spacer(),
          const Text(
            'Budget Calculator',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.save_outlined)),
        ],
      ),
    );
  }
}