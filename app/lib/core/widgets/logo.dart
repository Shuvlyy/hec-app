import 'package:flutter/material.dart';
import '../theme/app_design_system.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({
    super.key,
    this.size = 44,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.grayText.withOpacity(0.5),
        borderRadius: BorderRadius.circular(size * 0.25),
      ),
      // child: Image.asset('assets/images/logo.png'),
    );
  }
}
