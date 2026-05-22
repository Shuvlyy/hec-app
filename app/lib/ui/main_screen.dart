import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:native_glass_navbar/native_glass_navbar.dart';
import 'package:repill/l10n/app_localizations.dart';
import 'package:repill/theme/app_theme.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/prescriptions');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppTheme.primaryOrange.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.medical_services, color: AppTheme.primaryOrange, size: 24),
        ),
      ),
      body: widget.child,
      bottomNavigationBar: NativeGlassNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        tabs: [
          NativeGlassNavBarItem(label: l10n.today, symbol: 'house.fill'),
          NativeGlassNavBarItem(label: l10n.prescriptions, symbol: 'person.2.fill'),
          NativeGlassNavBarItem(label: l10n.profile, symbol: 'person.fill'),
        ],
        fallback: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.calendar_today_outlined), label: l10n.today),
            BottomNavigationBarItem(icon: const Icon(Icons.medical_information_rounded), label: l10n.prescriptions),
            BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: l10n.profile),
          ],
        ),
      ),
    );
  }
}
