import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://10.0.2.2:8000";
  static String? _token;

  Future<Map<String, dynamic>> loginUser(String user, String pass) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/login/'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": user, "password": pass}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data['access_token'];
        return {'status': 'success', 'data': data};
      }
      return {'status': 'error'};
    } catch (e) {
      return {'status': 'error'};
    }
  }

  Future<List<dynamic>> getAnnouncements() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/announcements/'),
      headers: {"Authorization": "Bearer $_token"},
    );
    return response.statusCode == 200 ? jsonDecode(response.body) : [];
  }
}
