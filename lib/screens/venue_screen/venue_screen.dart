import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/dummy_data/seed_venues.dart';
import 'package:ever_after_planner/models/venue_model.dart';
import 'package:ever_after_planner/screens/venue_screen/widgets/range_filters.dart';
import 'package:ever_after_planner/screens/venue_screen/widgets/venue_card.dart';
import 'package:flutter/material.dart';

class VenuesScreen extends StatefulWidget {
  const VenuesScreen({super.key});

  @override
  State<VenuesScreen> createState() => _VenuesScreenState();
}

class _VenuesScreenState extends State<VenuesScreen> {
  final List<VenueModel> allVenues = [];

  // Filters: budget in lakhs, capacity in guests
  RangeValues budget = const RangeValues(5, 20);
  RangeValues capacity = const RangeValues(50, 1000);

  @override
  void initState() {
    super.initState();
    allVenues.addAll(seedVenues);
  }

  List<VenueModel> _visible() {
    return allVenues.where((v) {
      final overlapsBudget =
          v.budgetMaxLakh >= budget.start && v.budgetMinLakh <= budget.end;
      final withinCapacity =
          v.capacity >= capacity.start && v.capacity <= capacity.end;
      return overlapsBudget && withinCapacity;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _visible();

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Padding(
        // No SafeArea by request; manual top padding
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: back + left-aligned title; no search, no filter icon
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Venues',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            RangeFilters(
              budget: budget,
              onBudgetChanged: (v) => setState(() => budget = v),
              capacity: capacity,
              onCapacityChanged: (v) => setState(() => capacity = v),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: visible.length != 0 ? ListView.separated(
                itemCount: visible.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) => VenueCard(venue: visible[i]),
              ) : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.place_outlined,size: 40,),
                          SizedBox(height: 20,),
                          Text('No Venues Found',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                          SizedBox(height: 10,),
                          Center(child: Text('Try adjusting your filters to see more options',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),))
                        ],
                      ),
                    ),
                    Container()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
