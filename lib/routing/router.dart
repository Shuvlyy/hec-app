import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milo/ui/main_screen.dart';
import 'package:milo/ui/home_page.dart';
import 'package:milo/ui/prescriptions_page.dart';
import 'package:milo/ui/prescription_details_page.dart';
import 'package:milo/ui/edit_prescription_page.dart';
import 'package:milo/ui/medication_details_page.dart';
import 'package:milo/ui/settings_page.dart';
import 'package:milo/ui/splash_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      pageBuilder: (context, state) => const NoTransitionPage(child: SplashScreen()),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          key: const ValueKey('shell'),
          child: MainScreen(child: child),
        );
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => const NoTransitionPage(child: HomePage()),
        ),
        GoRoute(
          path: '/prescriptions',
          pageBuilder: (context, state) => const NoTransitionPage(child: PrescriptionsPage()),
          routes: [
            GoRoute(
              path: 'details/:id',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => PrescriptionDetailsPage(prescriptionId: state.pathParameters['id']!),
            ),
            GoRoute(
              path: 'add',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const EditPrescriptionPage(),
            ),
            GoRoute(
              path: 'edit/:id',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => EditPrescriptionPage(prescriptionId: state.pathParameters['id']),
            ),
          ],
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) => const NoTransitionPage(child: SettingsPage()),
        ),
      ],
    ),
    GoRoute(
      path: '/medication-details/:id',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => MedicationDetailsPage(medicationId: state.pathParameters['id']!),
    ),
  ],
);
