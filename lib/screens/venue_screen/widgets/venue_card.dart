import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/models/venue_model.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatelessWidget {
  const VenueCard({super.key, required this.venue});

  final VenueModel venue;

  String _budgetText(VenueModel v) => '₹${v.budgetMinLakh}–${v.budgetMaxLakh}L';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imgHeight = 0.95 * 220.0; // card height ~220; image ~65%

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        border: const Border.fromBorderSide(BorderSide(color: AppColors.border)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image area ~65%
          SizedBox(
            width: width,
            height: imgHeight,
            child: Image.asset(
              venue.imageAsset,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        venue.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.star_rounded, size: 18, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(venue.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
                const SizedBox(height: 4),
                // Location
                Row(
                  children: [
                    const Icon(Icons.place_outlined, size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        venue.location,
                        style: const TextStyle(color: Colors.black87),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                // Capacity + Budget
                Row(
                  children: [
                    const Icon(Icons.groups_2_outlined, size: 16, color: Colors.black54),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text('Up to ${venue.capacity} guests',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Text(_budgetText(venue),
                        style: const TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
