import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final VoidCallback onTapAnnounce;
  final VoidCallback onTapGarbage;
  const DashboardScreen({
    super.key,
    required this.onTapAnnounce,
    required this.onTapGarbage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Feature Overview",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB93413),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: Colors.grey[100],
              leading: const Icon(Icons.campaign, color: Color(0xFFB93413)),
              title: const Text("Announcements"),
              onTap: onTapAnnounce,
            ),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: Colors.grey[100],
              leading: const Icon(
                Icons.local_shipping,
                color: Color(0xFFB93413),
              ),
              title: const Text("Garbage Schedule"),
              onTap: onTapGarbage,
            ),
          ),
        ],
      ),
    );
  }
}
