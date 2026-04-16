import 'package:flutter/material.dart';

class GarbageAlertsScreen extends StatefulWidget {
  const GarbageAlertsScreen({super.key});
  @override
  State<GarbageAlertsScreen> createState() => _GarbageAlertsScreenState();
}

class _GarbageAlertsScreenState extends State<GarbageAlertsScreen> {
  bool _isSilent = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Alert Notifications"),
          trailing: IconButton(
            icon: Icon(
              _isSilent ? Icons.notifications_off : Icons.notifications_active,
            ),
            onPressed: () => setState(() => _isSilent = !_isSilent),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Set reminder logic here
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Reminder set!")));
          },
          child: const Text("Set Reminder"),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Recent Collections",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.history, color: Color(0xFFB93413)),
                  title: Text("April 14, 2026"),
                  subtitle: Text("8:30 AM"),
                ),
              ),
              Card(
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.history, color: Color(0xFFB93413)),
                  title: Text("April 12, 2026"),
                  subtitle: Text("9:00 AM"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
