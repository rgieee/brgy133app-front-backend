import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  String _filter = "All";

  void _showDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Announcement Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const Text("Summary: Community Clean-up Drive"),
            const Text("Schedule: April 25, 2026 - 7:00 AM"),
            const Text("Requirements: Comfortable attire, Cleaning tools"),
            const Text(
              "Important Reminder: Wear masks at all times.",
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _filter,
                items: const [
                  DropdownMenuItem(value: "All", child: Text("All")),
                  DropdownMenuItem(value: "Events", child: Text("Events")),
                  DropdownMenuItem(value: "Alerts", child: Text("Alerts")),
                ],
                onChanged: (value) => setState(() => _filter = value!),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, i) => Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text("Announcement #${i + 1}"),
                subtitle: const Text("Brief summary of the post..."),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB93413),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _showDetails(context),
                  child: const Text("Read More"),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
