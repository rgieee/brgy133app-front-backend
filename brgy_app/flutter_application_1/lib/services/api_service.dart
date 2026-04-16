import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // IP address para sa Android Emulator para maka-konekta sa PC localhost
  final String baseUrl = "http://10.0.2.2:8000";
  static String? _token;

  Future<Map<String, dynamic>> loginUser(String user, String pass) async {
    try {
      debugPrint("--- LOGIN ATTEMPT ---");
      debugPrint("URL: $baseUrl/api/login/");

      final response = await http.post(
        Uri.parse('$baseUrl/api/login/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": user, "password": pass}),
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['access_token'];
        return {'status': 'success', 'data': data};
      } else if (response.statusCode == 401) {
        return {
          'status': 'error',
          'message': 'Mali ang username o password (401)',
        };
      } else if (response.statusCode == 422) {
        return {
          'status': 'error',
          'message': 'Data format error sa request (422)',
        };
      } else {
        return {
          'status': 'error',
          'message': 'Server error: ${response.statusCode}',
        };
      }
    } catch (e) {
      debugPrint("Connection Error: $e");
      return {
        'status': 'error',
        'message':
            'Hindi makakonekta sa server. Siguraduhing running ang Uvicorn.',
      };
    }
  }

  Future<List<dynamic>> getAnnouncements() async {
    if (_token == null) {
      debugPrint("No token found. Login first.");
      return [];
    }

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/announcements/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      debugPrint("Failed to load announcements: ${response.statusCode}");
      return [];
    } catch (e) {
      debugPrint("Announcement Error: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> submitFeedback(
    String subject,
    String content,
  ) async {
    if (_token == null) {
      debugPrint("No token found. Login first.");
      return {'status': 'error', 'message': 'Not logged in'};
    }

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/feedback/'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_token",
        },
        body: jsonEncode({"subject": subject, "content": content}),
      );

      if (response.statusCode == 200) {
        return {'status': 'success'};
      } else {
        return {'status': 'error', 'message': 'Failed to submit feedback'};
      }
    } catch (e) {
      debugPrint("Feedback Error: $e");
      return {'status': 'error', 'message': 'Connection error'};
    }
  }
}
