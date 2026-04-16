import 'package:flutter/material.dart';
import 'main_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  void _showForgotDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          "To reset your password, please contact your barangay office. The admin will assist you in updating your account.",
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
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.location_city,
                    size: 80,
                    color: Color(0xFFB93413),
                  ),
                  const Text(
                    "Barangay 133",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB93413),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFB93413),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainNavigation(username: _userController.text),
                        ),
                      ),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _showForgotDialog,
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Color(0xFFB93413)),
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
