import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milo/ui/main_screen.dart';
import 'package:milo/ui/home_page.dart';
import 'package:milo/ui/prescriptions_page.dart';
import 'package:milo/ui/prescription_details_page.dart';
import 'package:milo/ui/edit_prescription_page.dart';
import 'package:milo/ui/medication_details_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainScreen(child: child);
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
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(child: Center(child: Text("Profile"))),
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
