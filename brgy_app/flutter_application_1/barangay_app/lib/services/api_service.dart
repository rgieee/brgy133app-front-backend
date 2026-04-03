import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  // Backend URL - Update this to your server address (e.g., http://192.168.1.100:8000 for network)
  static const String baseUrl = 'http://localhost:8000';
  static String? _authToken;
  static String? _userRole;
  static int? _userId;

  // Getters
  static String? get authToken => _authToken;
  static String? get userRole => _userRole;
  static int? get userId => _userId;

  // Setters
  static void setToken(String token) => _authToken = token;
  static void setUserRole(String role) => _userRole = role;
  static void setUserId(int id) => _userId = id;

  // Clear session on logout
  static void clearSession() {
    _authToken = null;
    _userRole = null;
    _userId = null;
  }

  // Build headers with auth token
  static Map<String, String> _getHeaders({bool includeAuth = true}) {
    final headers = {'Content-Type': 'application/json'};
    if (includeAuth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    return headers;
  }

  // ============================================
  // AUTHENTICATION
  // ============================================

  /// Login with username and password
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/login/'),
            headers: _getHeaders(includeAuth: false),
            body: jsonEncode({'username': username, 'password': password}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _authToken = data['access_token'];
        _userRole = data['role'];
        _userId = data['user_id'];
        return {'success': true, ...data};
      } else {
        return {
          'success': false,
          'message': 'Invalid username or password',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  // ============================================
  // ANNOUNCEMENTS (FR4 & FR9)
  // ============================================

  /// Fetch all announcements
  static Future<List<Map<String, dynamic>>> getAnnouncements() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/announcements/'), headers: _getHeaders())
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  /// Create announcement (Official+ only)
  static Future<Map<String, dynamic>> createAnnouncement({
    required String title,
    required String content,
    required String datePosted,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/announcements/'),
            headers: _getHeaders(),
            body: jsonEncode({
              'title': title,
              'content': content,
              'date_posted': datePosted,
            }),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return {'success': true, ...jsonDecode(response.body)};
      }
      return {'success': false, 'message': 'Failed to create announcement'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  // ============================================
  // FEEDBACK & COMPLAINTS (FR5 & FR10)
  // ============================================

  /// Submit feedback
  static Future<Map<String, dynamic>> submitFeedback({
    required String subject,
    required String content,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/feedback/'),
            headers: _getHeaders(),
            body: jsonEncode({'subject': subject, 'content': content}),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 201) {
        return {'success': true, ...jsonDecode(response.body)};
      }
      return {'success': false, 'message': 'Failed to submit feedback'};
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  /// Get all feedback (Official+ only)
  static Future<List<Map<String, dynamic>>> getFeedback() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/feedback/'), headers: _getHeaders())
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // NOTIFICATIONS & ALERTS
  // ============================================

  /// Get notifications/alerts
  static Future<List<Map<String, dynamic>>> getNotifications() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/notifications/'), headers: _getHeaders())
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // ACTIVITY HISTORY (FR16)
  // ============================================

  /// Get user's activity history
  static Future<List<Map<String, dynamic>>> getActivityHistory() async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl/api/activity-history/'),
            headers: _getHeaders(),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // RESIDENTS (FR2 - Super Admin only)
  // ============================================

  /// Get all residents
  static Future<List<Map<String, dynamic>>> getResidents() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/residents/'), headers: _getHeaders())
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // REPORTS (Official+ only)
  // ============================================

  /// Get all reports
  static Future<List<Map<String, dynamic>>> getReports() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/api/reports/'), headers: _getHeaders())
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.cast<Map<String, dynamic>>();
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ============================================
  // HEALTH CHECK
  // ============================================

  /// Check if backend is online
  static Future<bool> healthCheck() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/'))
          .timeout(const Duration(seconds: 5));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
