import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'announcements_screen.dart';
import 'garbage_alerts_screen.dart';
import 'activity_history_screen.dart';
import 'feedback_screen.dart';
import 'login_screen.dart';

class MainNavigation extends StatefulWidget {
  final String username;
  const MainNavigation({super.key, required this.username});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  Widget _currentScreen = const SizedBox(); // Placeholder

  @override
  void initState() {
    super.initState();
    _currentScreen = DashboardScreen(
      onTapAnnounce: () => _navigateTo(const AnnouncementsScreen()),
      onTapGarbage: () => _navigateTo(const GarbageAlertsScreen()),
    );
  }

  void _navigateTo(Widget screen) {
    setState(() {
      _currentScreen = screen;
    });
    Navigator.pop(context); // Close drawer
  }

  void _showProfile() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("User Profile"),
        content: Text("Username: ${widget.username}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Column(
          children: [
            const Icon(Icons.location_city, size: 30),
            const Text("Barangay 133", style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: _showProfile,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text("Welcome, ${widget.username}"),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFB93413)),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () => _navigateTo(
                DashboardScreen(
                  onTapAnnounce: () => _navigateTo(const AnnouncementsScreen()),
                  onTapGarbage: () => _navigateTo(const GarbageAlertsScreen()),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.campaign),
              title: const Text("Announcements"),
              onTap: () => _navigateTo(const AnnouncementsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text("Garbage Alerts"),
              onTap: () => _navigateTo(const GarbageAlertsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Activity History"),
              onTap: () => _navigateTo(const ActivityHistoryScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () => _navigateTo(const FeedbackScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: _currentScreen,
    );
  }
}
