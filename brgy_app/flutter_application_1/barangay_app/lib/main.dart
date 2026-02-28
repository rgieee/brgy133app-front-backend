import 'package:flutter/material.dart';

void main() {
  runApp(const BarangayApp());
}

class BarangayApp extends StatelessWidget {
  const BarangayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green), // Kulay ng Barangay (Green)
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barangay Connect'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1: GARBAGE TRUCK NOTIFICATION ---
            const Card(
              color: Colors.amberAccent,
              child: ListTile(
                leading: Icon(Icons.delete_outline, color: Colors.black),
                title: Text('Garbage Truck Alert!', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Papunta na ang truck sa Zone 4 sa loob ng 10 mins.'),
              ),
            ),
            const SizedBox(height: 20),

            // --- SECTION 2: ANNOUNCEMENTS ---
            const Text('Latest Announcements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.campaign, color: Colors.blue),
                    title: Text('Libreng Bakuna sa Health Center'),
                    subtitle: Text('Feb 25, 2026 | 8:00 AM - 4:00 PM'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.event, color: Colors.red),
                    title: Text('Barangay Assembly Meeting'),
                    subtitle: Text('March 1, 2026 | Covered Court'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}