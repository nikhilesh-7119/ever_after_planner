import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/models/guest_model.dart';
import 'package:ever_after_planner/widgets/cards.dart';
import 'package:flutter/material.dart';

class GuestCard extends StatelessWidget {
  const GuestCard({
    super.key,
    required this.guest,
    required this.onStatusChanged,
  });

  final GuestModel guest;
  final ValueChanged<RsvpStatus> onStatusChanged;

  Color _statusColor(RsvpStatus s) {
    switch (s) {
      case RsvpStatus.yes:
        return AppColors.yes;
      case RsvpStatus.no:
        return AppColors.no;
      case RsvpStatus.maybe:
        return AppColors.maybe;
      case RsvpStatus.pending:
        return AppColors.pending;
    }
  }

  Widget _statusPill(String text, bool active, Color color, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: active ? color : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = guest.status;
    return Cards(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(guest.fullName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(guest.email, style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 4),
              Text(guest.phone, style: const TextStyle(color: Colors.black87)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _statusPill('yes', s == RsvpStatus.yes, AppColors.yes,
                      () => onStatusChanged(RsvpStatus.yes)),
                  const SizedBox(width: 8),
                  _statusPill('no', s == RsvpStatus.no, AppColors.no,
                      () => onStatusChanged(RsvpStatus.no)),
                  const SizedBox(width: 8),
                  _statusPill('maybe', s == RsvpStatus.maybe, AppColors.maybe,
                      () => onStatusChanged(RsvpStatus.maybe)),
                ],
              ),
            ],
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _statusColor(s),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(  
                s.name, // yes/no/maybe/pending
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
