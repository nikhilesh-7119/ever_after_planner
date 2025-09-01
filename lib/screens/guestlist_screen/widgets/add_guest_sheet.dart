import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/models/guest_model.dart';
import 'package:flutter/material.dart';

class AddGuestSheet extends StatefulWidget {
  const AddGuestSheet({super.key, required this.onSubmit});

  final void Function(
    String name,
    String phone,
    String email,
    RsvpStatus? status,
  )
  onSubmit;

  @override
  State<AddGuestSheet> createState() => _AddGuestSheetState();
}

class _AddGuestSheetState extends State<AddGuestSheet> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  RsvpStatus? picked;

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea( // keep sheet content off system UI; page itself uses custom padding
  //     top: false,
  //     child: Padding(
  //       padding: EdgeInsets.only(
  //         left: 16, right: 16,
  //         bottom: MediaQuery.of(context).viewInsets.bottom + 16,
  //         top: 12,
  //       ),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Container(
  //               width: 40, height: 4,
  //               decoration: BoxDecoration(
  //                 color: Colors.black26, borderRadius: BorderRadius.circular(2),
  //               ),
  //             ),
  //             const SizedBox(height: 12),
  //             const Text('Add guest', style: TextStyle(fontWeight: FontWeight.w700)),
  //             const SizedBox(height: 12),
  //             TextFormField(
  //               controller: nameCtrl,
  //               decoration: const InputDecoration(
  //                 labelText: 'Full name',
  //                 border: OutlineInputBorder(),
  //               ),
  //               validator: (v) => (v==null || v.trim().isEmpty) ? 'Enter name' : null,
  //             ),
  //             const SizedBox(height: 10),
  //             TextFormField(
  //               controller: phoneCtrl,
  //               decoration: const InputDecoration(
  //                 labelText: 'Phone number',
  //                 border: OutlineInputBorder(),
  //               ),
  //               validator: (v) => (v==null || v.trim().isEmpty) ? 'Enter phone' : null,
  //             ),
  //             const SizedBox(height: 10),
  //             TextFormField(
  //               controller: emailCtrl,
  //               decoration: const InputDecoration(
  //                 labelText: 'Email',
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             const SizedBox(height: 12),
  //             Align(
  //               alignment: Alignment.centerLeft,
  //               child: Wrap(
  //                 spacing: 8,
  //                 children: [
  //                   ChoiceChip(
  //                     label: const Text('yes'),
  //                     selected: picked == RsvpStatus.yes,
  //                     onSelected: (_) => setState(() => picked = RsvpStatus.yes),
  //                   ),
  //                   ChoiceChip(
  //                     label: const Text('no'),
  //                     selected: picked == RsvpStatus.no,
  //                     onSelected: (_) => setState(() => picked = RsvpStatus.no),
  //                   ),
  //                   ChoiceChip(
  //                     label: const Text('maybe'),
  //                     selected: picked == RsvpStatus.maybe,
  //                     onSelected: (_) => setState(() => picked = RsvpStatus.maybe),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             const SizedBox(height: 12),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: OutlinedButton(
  //                     onPressed: () => Navigator.pop(context),
  //                     child: const Text('Cancel'),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 8),
  //                 Expanded(
  //                   child: ElevatedButton(
  //                     style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
  //                     onPressed: () {
  //                       if (_formKey.currentState!.validate()) {
  //                         widget.onSubmit(
  //                           nameCtrl.text.trim(),
  //                           phoneCtrl.text.trim(),
  //                           emailCtrl.text.trim(),
  //                           picked, // null => pending
  //                         );
  //                         Navigator.pop(context);
  //                       }
  //                     },
  //                     child: const Text('OK', style: TextStyle(color: Colors.white)),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // 1) Make content scrollable
    return SingleChildScrollView(
      // allows vertical scroll when keyboard shows
      // 2) Push content above keyboard
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ), // dynamic bottom space = keyboard height
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // let column take only needed height
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Text(
              'Add guest',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            // fields...
            TextFormField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Full name',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter name' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Phone number',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Enter phone' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 8,
              children: [
                ChoiceChip(
                  backgroundColor: Colors.white,
                  label: const Text('yes'),
                  selected: picked == RsvpStatus.yes,
                  onSelected: (_) => setState(() => picked = RsvpStatus.yes),
                ),
                ChoiceChip(
                  backgroundColor: Colors.white,
                  label: const Text('no'),
                  selected: picked == RsvpStatus.no,
                  onSelected: (_) => setState(() => picked = RsvpStatus.no),
                ),
                ChoiceChip(
                  backgroundColor: Colors.white,
                  label: const Text('maybe'),
                  selected: picked == RsvpStatus.maybe,
                  onSelected: (_) => setState(() => picked = RsvpStatus.maybe),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSubmit(
                          nameCtrl.text.trim(),
                          phoneCtrl.text.trim(),
                          emailCtrl.text.trim(),
                          picked,
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('OK'),
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
