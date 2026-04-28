import 'package:flutter/material.dart';
import 'file_picker_stub.dart';
import 'services/api_service.dart';
import 'widgets/background.dart';

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

// ============================================
// LOGIN UI START
// ============================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both username and password"),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.login(
        _userController.text,
        _passController.text,
      );

      if (mounted) {
        if (result['success'] == true) {
          addLog("Logged in as ${_userController.text}");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainNavigation(
                username: _userController.text,
                userRole: result['role'] ?? 'Resident',
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Login failed')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
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
      body: Background(
        imagePath: 'assets/image/barangay133bg2.jpg',
        blurAmount: 15.0,
        child: Container(
          color: Colors.black.withValues(alpha: 0.3),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/image/brgy_logo.jpg',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.location_city,
                        size: 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "BARANGAY 133",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                    ),
                  ),
                  const SizedBox(height: 40),
                  // --- USERNAME INPUT ---
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Colors.white.withValues(
                        alpha: 0.9,
                      ), // Semi-transparent white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // --- PASSWORD INPUT ---
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withValues(
                        alpha: 0.9,
                      ), // Semi-transparent white
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 25),
                  // --- LOGIN BUTTON ---
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 199, 84, 56),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "LOGIN",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: _forgotPassword,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 42, 105, 241),
                        decoration: TextDecoration.underline,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// ============================================
// LOGIN UI END
// ============================================

class MainNavigation extends StatefulWidget {
  final String username;
  final String userRole;
  const MainNavigation({
    super.key,
    required this.username,
    this.userRole = 'Resident',
  });
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
                        backgroundImage: AssetImage(
                          'assets/image/brgy_logo.jpg',
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
              selected: _index == 0,
              onTap: () {
                setState(() => _index = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.campaign),
              title: const Text("Announcements"),
              selected: _index == 1,
              onTap: () {
                setState(() => _index = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep),
              title: const Text("Garbage Alerts"),
              selected: _index == 2,
              onTap: () {
                setState(() => _index = 2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Activity History"),
              selected: _index == 3,
              onTap: () {
                setState(() => _index = 3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.feedback),
              title: const Text("Feedback"),
              selected: _index == 4,
              onTap: () {
                setState(() => _index = 4);
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
      body: Container(color: Colors.white, child: _pages[_index]),
    );
  }
}

// ============================================
// DASHBOARD START
// ============================================
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
// ============================================
// DASHBOARD END
// ============================================

// ============================================
// ANNOUNCEMENTS START
// ============================================
class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});
  @override
  State<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  List<Map<String, dynamic>> _announcements = [];
  List<Map<String, dynamic>> _filtered = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAnnouncements();
  }

  Future<void> _loadAnnouncements() async {
    setState(() => _isLoading = true);
    try {
      final announcements = await ApiService.getAnnouncements();
      if (mounted) {
        setState(() {
          _announcements = announcements;
          _filtered = List.from(_announcements);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading announcements: $e')),
        );
      }
    }
  }

  void _showDetails(Map<String, dynamic> data) {
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
              data['title'] ?? 'Announcement',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              data['date_posted'] ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            const Divider(),
            const Text(
              "Details:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(data['content'] ?? 'No details provided'),
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
              () => _filtered = _announcements
                  .where(
                    (i) =>
                        (i['title'] ?? '').toLowerCase().contains(
                          v.toLowerCase(),
                        ) ||
                        (i['content'] ?? '').toLowerCase().contains(
                          v.toLowerCase(),
                        ),
                  )
                  .toList(),
            ),
            decoration: const InputDecoration(
              labelText: 'Search announcements',
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _filtered.isEmpty
              ? const Center(child: Text('No announcements found'))
              : RefreshIndicator(
                  onRefresh: _loadAnnouncements,
                  child: ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(_filtered[index]['title'] ?? 'Announcement'),
                      subtitle: Text(
                        _filtered[index]['date_posted'] ?? 'No date',
                      ),
                      trailing: TextButton(
                        onPressed: () => _showDetails(_filtered[index]),
                        child: const Text("Read More"),
                      ),
                      leading: const Icon(Icons.campaign, color: Colors.orange),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
// ============================================
// ANNOUNCEMENTS END
// ============================================

// ============================================
// GARBAGE ALERTS START
// ============================================
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
// ============================================
// GARBAGE ALERTS END
// ============================================

// ============================================
// ACTIVITY HISTORY START
// ============================================
class ActivityHistoryPage extends StatefulWidget {
  const ActivityHistoryPage({super.key});
  @override
  State<ActivityHistoryPage> createState() => _ActivityHistoryPageState();
}

class _ActivityHistoryPageState extends State<ActivityHistoryPage> {
  List<Map<String, dynamic>> _history = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadActivityHistory();
  }

  Future<void> _loadActivityHistory() async {
    setState(() => _isLoading = true);
    try {
      final history = await ApiService.getActivityHistory();
      if (mounted) {
        setState(() {
          _history = history;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : _history.isEmpty
        ? const Center(child: Text('No activity history'))
        : RefreshIndicator(
            onRefresh: _loadActivityHistory,
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, i) => ListTile(
                leading: const Icon(Icons.history),
                title: Text(_history[i]['action_type'] ?? 'Unknown action'),
                subtitle: Text(_history[i]['timestamp'] ?? 'No timestamp'),
              ),
            ),
          );
  }
}
// ============================================
// ACTIVITY HISTORY END
// ============================================

// ============================================
// FEEDBACK START
// ============================================
class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _subjController = TextEditingController();
  final _msgController = TextEditingController();
  String _fileName = "None";

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        setState(() {
          _fileName = result.files.single.name;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error picking file: $e")));
      }
    }
  }

  void _submitFeedback() {
    if (_msgController.text.isEmpty || _subjController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Punan ang lahat ng fields.")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
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
              Navigator.pop(context);
              _sendFeedbackToBackend();
            },
            child: const Text("YES"),
          ),
        ],
      ),
    );
  }

  Future<void> _sendFeedbackToBackend() async {
    try {
      final result = await ApiService.submitFeedback(
        subject: _subjController.text,
        content: _msgController.text,
      );

      if (mounted) {
        if (result['success'] == true) {
          _showSuccessMessage();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Failed to submit')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  void _showSuccessMessage() {
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
                setState(() {
                  _fileName = "None";
                });
                Navigator.pop(context);
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
                onPressed: _pickFile,
                icon: const Icon(Icons.attach_file),
                label: const Text("Attach"),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(_fileName, overflow: TextOverflow.ellipsis)),
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

// ============================================
// FEEDBACK END
// ============================================
