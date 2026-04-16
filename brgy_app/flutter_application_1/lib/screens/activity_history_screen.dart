import 'package:flutter/material.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(Icons.login, color: Color(0xFFB93413)),
            title: Text("Logged in"),
            subtitle: Text("Just now"),
          ),
        ),
        Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Icon(Icons.campaign, color: Color(0xFFB93413)),
            title: Text("Viewed Announcements"),
            subtitle: Text("5 mins ago"),
          ),
        ),
      ],
    );
  }
}
