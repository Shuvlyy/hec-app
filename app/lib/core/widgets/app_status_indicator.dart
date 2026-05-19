import 'package:flutter/material.dart';

class AppStatusIndicator extends StatelessWidget {
  final bool isDoctorLinked;
  final bool isAccountCreated;

  const AppStatusIndicator({
    super.key,
    this.isDoctorLinked = false,
    this.isAccountCreated = true,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 2,
            width: 80,
            color: Colors.grey.shade300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(
                Icons.person_outline,
                isAccountCreated ? Colors.red : Colors.grey,
              ),
              const SizedBox(width: 40),
              _buildIcon(
                Icons.medical_services_outlined,
                isDoctorLinked ? Colors.blue : Colors.grey.shade400,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}
