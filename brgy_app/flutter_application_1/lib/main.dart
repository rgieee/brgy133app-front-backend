import 'package:flutter/material.dart';

void main() {
  runApp(const Barangay133App());
}

class Barangay133App extends StatelessWidget {
  const Barangay133App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BARANGAY 133 APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 185, 52, 19),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

// --- GLOBAL STATE PARA SA LOGS ---
List<Map<String, String>> activityLogs = [
  {"title": "System", "subtitle": "App started", "time": "Just now"},
];

void addLog(String action) {
  final now = DateTime.now();
  activityLogs.insert(0, {
    "title": "User Activity",
    "subtitle": action,
    "time": "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
  });
}

// --- 1. LOGIN PAGE ---
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  void _login() {
    if (_userController.text.isNotEmpty) {
      addLog("Logged in as ${_userController.text}");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigation(username: _userController.text),
        ),
      );
    }
  }

  void _forgotPassword() {
    addLog("Forgot Password clicked");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Forgot Password?"),
        content: const Text(
          "Mangyaring makipag-ugnayan sa ating Barangay Admin para sa pag-reset ng inyong account credentials.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_city,
                size: 100,
                color: Colors.blueAccent,
              ),
              const Text(
                "BARANGAY 133",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 185, 52, 19),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _login,
                  child: const Text("LOGIN"),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: _forgotPassword,
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. MAIN NAVIGATION ---
class MainNavigation extends StatefulWidget {
  final String username;
  const MainNavigation({super.key, required this.username});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _index = 0;
  bool isNotifActive = true;

  final List<String> _pageTitles = [
    "Dashboard",
    "Announcements",
    "Garbage Alerts",
    "Activity History",
    "Feedback",
  ];

  final List<Widget> _pages = [
    const DashboardPage(),
    const AnnouncementPage(),
    const GarbageAlertPage(),
    const ActivityHistoryPage(),
    const FeedbackPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_index]),
        backgroundColor: const Color.fromARGB(255, 185, 52, 19),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              isNotifActive
                  ? Icons.notifications_active
                  : Icons.notifications_off,
            ),
            onPressed: () {
              setState(() => isNotifActive = !isNotifActive);
              addLog("Notif: ${isNotifActive ? 'ON' : 'OFF'}");
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 60,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              color: const Color.fromARGB(255, 185, 52, 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.location_city,
                          size: 35,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "BRGY 133",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "PORTAL",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        widget.username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(Icons.verified, color: Colors.blue, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                setState(() => _index = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.campaign),
              title: const Text("Announcements"),
              onTap: () {
                setState(() => _index = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: const Text("Garbage Alerts"),
              onTap: () {
                setState(() => _index = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Activity History"),
              onTap: () {
                setState(() => _index = 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              onTap: () {
                setState(() => _index = 4);
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      body: _pages[_index],
    );
  }
}

// --- 3. DASHBOARD ---
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(15),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        _buildCard("Water Notice", Icons.water_drop, Colors.blue),
        _buildCard("Ayuda", Icons.card_giftcard, Colors.orange),
        _buildCard("Assembly", Icons.group, Colors.green),
        _buildCard("Garbage", Icons.local_shipping, Colors.amber),
      ],
    );
  }

  Widget _buildCard(String t, IconData i, Color c) {
    return Card(
      child: InkWell(
        onTap: () => addLog("Clicked $t"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(i, size: 40, color: c),
            const SizedBox(height: 10),
            Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// --- 4. ANNOUNCEMENTS (SEARCH & READ MORE) ---
class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  final List<Map<String, String>> _allData = [
    {
      "title": "Ayuda Distribution",
      "date": "Feb 24, 2026",
      "desc": "Regular financial assistance for senior citizens.",
      "req": "* Senior Citizen ID\n* Brgy Clearance\n* Original ID",
    },
    {
      "title": "Clean Up Drive",
      "date": "Feb 26, 2026",
      "desc": "Community cleaning activity to prevent Dengue.",
      "req": "* Bring broom\n* Comfortable clothes",
    },
  ];
  List<Map<String, String>> _filtered = [];

  @override
  void initState() {
    _filtered = List.from(_allData);
    super.initState();
  }

  void _showDetails(Map<String, String> data) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['title']!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(data['date']!, style: const TextStyle(color: Colors.grey)),
            const Divider(),
            const Text(
              "Details:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data['desc']!),
            const SizedBox(height: 15),
            const Text(
              "Requirements:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data['req']!),
            const SizedBox(height: 20),
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
          child: TextField(
            onChanged: (v) => setState(
              () => _filtered = _allData
                  .where(
                    (i) => i['title']!.toLowerCase().contains(v.toLowerCase()),
                  )
                  .toList(),
            ),
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_filtered[index]['title']!),
              subtitle: Text(_filtered[index]['date']!),
              trailing: TextButton(
                onPressed: () => _showDetails(_filtered[index]),
                child: const Text("Read More"),
              ),
              leading: const Icon(Icons.campaign, color: Colors.orange),
            ),
          ),
        ),
      ],
    );
  }
}

// --- 5. GARBAGE ALERTS (WITH HISTORY) ---
class GarbageAlertPage extends StatefulWidget {
  const GarbageAlertPage({super.key});
  @override
  State<GarbageAlertPage> createState() => _GarbageAlertPageState();
}

class _GarbageAlertPageState extends State<GarbageAlertPage> {
  bool isRem = false;
  final List<String> _collectionHistory = [
    "Feb 22 - 8:30 AM",
    "Feb 20 - 9:00 AM",
    "Feb 18 - 8:45 AM",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            isRem ? Icons.notifications_active : Icons.notifications_none,
            color: isRem ? Colors.blue : Colors.grey,
          ),
          title: const Text("Reminders"),
          trailing: Switch(
            value: isRem,
            onChanged: (v) => setState(() => isRem = v),
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Collection History",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _collectionHistory.length,
            itemBuilder: (context, i) => ListTile(
              leading: const Icon(Icons.local_shipping, size: 20),
              title: Text(_collectionHistory[i]),
              dense: true,
            ),
          ),
        ),
      ],
    );
  }
}

// --- 6. ACTIVITY HISTORY ---
class ActivityHistoryPage extends StatelessWidget {
  const ActivityHistoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activityLogs.length,
      itemBuilder: (context, i) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(activityLogs[i]['subtitle']!),
        subtitle: Text(activityLogs[i]['time']!),
      ),
    );
  }
}

// --- 7. FEEDBACK (WITH DOUBLE CONFIRMATION LOGIC) ---
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _subjController = TextEditingController();
  final _msgController = TextEditingController();
  String _fileName = "None";

  void _submitFeedback() {
    if (_msgController.text.isEmpty || _subjController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Punan ang lahat ng fields.")),
      );
      return;
    }

    // UNANG CONFIRMATION: TANONG BAGO I-YES
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Kumpirmasyon"),
        content: const Text(
          "Sigurado ka na ba talaga na nais mong i-submit ang mensaheng ito sa Barangay Admin?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("NO"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close Confirmation
              _showSuccessMessage(); // Open Success Message
            },
            child: const Text("YES"),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage() {
    // IKALAWANG MESSAGE: SUCCESS FEEDBACK
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Tagumpay! Ang iyong mensahe ay naipadala na sa Barangay Admin.",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                addLog("Feedback Sent: ${_subjController.text}");
                _subjController.clear();
                _msgController.clear();
                setState(() => _fileName = "None");
                Navigator.pop(context); // Close Success Dialog
              },
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: _subjController,
            decoration: const InputDecoration(
              labelText: "Subject",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () => setState(() => _fileName = "report_file.jpg"),
                icon: const Icon(Icons.attach_file),
                label: const Text("Attach"),
              ),
              const SizedBox(width: 10),
              Text(_fileName),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _msgController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: "Message",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submitFeedback,
              child: const Text("SUBMIT"),
            ),
          ),
        ],
      ),
    );
  }
}
