import 'package:flutter/material.dart';

class DoctorAvatar extends StatelessWidget {
  final String name;
  final double radius;
  final double fontSize;

  const DoctorAvatar({
    super.key,
    required this.name,
    this.radius = 24,
    this.fontSize = 16,
  });

  Color _getAccentColor(String name) {
    final colors = [
      const Color(0xFF007AFF),
      const Color(0xFF5856D6),
      const Color(0xFFFF2D55),
      const Color(0xFFFF9500),
      const Color(0xFF34C759),
      const Color(0xFFAF52DE),
    ];
    return colors[name.length % colors.length];
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      // Handle "Dr. Name" or "First Last"
      final first = parts[0].replaceAll('.', '');
      if (first.toLowerCase() == 'dr' && parts.length > 2) {
         return (parts[1][0] + parts[2][0]).toUpperCase();
      }
      return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
    }
    return name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getAccentColor(name);
    return CircleAvatar(
      radius: radius,
      backgroundColor: accentColor.withOpacity(0.1),
      child: Text(
        _getInitials(name),
        style: TextStyle(
          color: accentColor,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          fontFamily: 'SF Pro',
        ),
      ),
    );
  }
}
