import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:native_glass_navbar/native_glass_navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milo/l10n/app_localizations.dart';
import 'package:milo/theme/app_theme.dart';

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
        toolbarHeight: 72,
        centerTitle: true,
        title: Container(
          width: 54,
          height: 54,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SvgPicture.asset(
            'assets/tete.svg',
          ),
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
