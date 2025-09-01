import 'package:ever_after_planner/assets/theme/app_Colors.dart';
import 'package:ever_after_planner/dummy_data/seed_guests.dart';
import 'package:ever_after_planner/models/guest_model.dart';
import 'package:ever_after_planner/screens/guestlist_screen/widgets/add_guest_sheet.dart';
import 'package:ever_after_planner/screens/guestlist_screen/widgets/filter_tab.dart';
import 'package:ever_after_planner/screens/guestlist_screen/widgets/guests_card.dart';
import 'package:ever_after_planner/screens/guestlist_screen/widgets/summary_counter.dart';
import 'package:flutter/material.dart';

class GuestsScreen extends StatefulWidget {
  const GuestsScreen({super.key});

  @override
  State<GuestsScreen> createState() => _GuestsScreenState();
}

class _GuestsScreenState extends State<GuestsScreen> {
  // Source of truth
  final List<GuestModel> allGuests = [];

  // UI state
  FilterTab active = FilterTab.all;

  // Convenience getters
  List<GuestModel> get yesGuests =>
      allGuests.where((g) => g.status == RsvpStatus.yes).toList();
  List<GuestModel> get noGuests =>
      allGuests.where((g) => g.status == RsvpStatus.no).toList();
  List<GuestModel> get maybeGuests =>
      allGuests.where((g) => g.status == RsvpStatus.maybe).toList();
  List<GuestModel> get pendingGuests =>
      allGuests.where((g) => g.status == RsvpStatus.pending).toList();

  @override
  void initState() {
    super.initState();
    allGuests.addAll(seedGuests);
    _sortAll();
  }

  void _sortAll() {
    allGuests.sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));
  }

  List<GuestModel> _visible() {
    switch (active) {
      case FilterTab.all:
        return List<GuestModel>.from(allGuests);
      case FilterTab.yes:
        return yesGuests;
      case FilterTab.no:
        return noGuests;
      case FilterTab.maybe:
        return maybeGuests;
      case FilterTab.pending:
        return pendingGuests;
    }
  }

  void _updateStatus(GuestModel g, RsvpStatus s) {
    setState(() {
      g.status = s;
      _sortAll();
    });
  }

  void _addGuest(String name, String phone, String email, RsvpStatus? status) {
    setState(() {
      allGuests.add(GuestModel(
        id: '${DateTime.now().microsecondsSinceEpoch}',
        fullName: name,
        email: email,
        phone: phone,
        status: status ?? RsvpStatus.pending,
      ));
      _sortAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _visible()..sort((a, b) => a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase()));

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
            builder: (ctx) => FractionallySizedBox(
              heightFactor: 0.6,
              child: AddGuestSheet(onSubmit: _addGuest),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        // No SafeArea: manual top padding
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Guests',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Summary counters (not clickable)
            SummaryCounters(
              total: allGuests.length,
              yes: yesGuests.length,
              no: noGuests.length,
              maybe: maybeGuests.length,
              totalColor: Colors.white,
            ),
            const SizedBox(height: 12),
            // Filter strip (scrollable, no scrollbar UI)
            FilterStrip(
              active: active,
              onChanged: (f) => setState(() => active = f),
            ),
            // const SizedBox(height: 12),
            Expanded(
              child: list.isEmpty
                  ? const _EmptyState()
                  : ListView.separated(
                      itemCount: list.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final g = list[i];
                        return GuestCard(
                          guest: g,
                          onStatusChanged: (s) => _updateStatus(g, s),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.person_add_alt_1, size: 40, color: Colors.black38),
          SizedBox(height: 8),
          Text('No guests found', style: TextStyle(fontWeight: FontWeight.w700)),
          SizedBox(height: 4),
          Text('Try adding a new guest', style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
