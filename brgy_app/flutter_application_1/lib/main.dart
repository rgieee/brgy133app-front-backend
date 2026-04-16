import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const Barangay133App());
}

class Barangay133App extends StatelessWidget {
  const Barangay133App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barangay 133',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB93413)),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
