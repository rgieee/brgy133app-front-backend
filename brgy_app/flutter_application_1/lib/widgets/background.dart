import 'package:flutter/material.dart';
import 'dart:ui';

class Background extends StatelessWidget {
  final Widget child;
  final String imagePath;
  final double blurAmount;

  const Background({
    super.key,
    required this.child,
    this.imagePath =
        'assets/image/barangay133bg2.jpg', // Sinigurado ang path base sa pubspec mo
    this.blurAmount = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(color: Colors.grey[200]),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
            child: Container(
              // Inayos ang deprecated withOpacity
              color: Colors.black.withValues(alpha: 0.2),
            ),
          ),
        ),
        Positioned.fill(child: child),
      ],
    );
  }
}
