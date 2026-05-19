import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hec_app/features/profile/presentation/profile_screen.dart';
import 'package:native_glass_navbar/native_glass_navbar.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/auth/presentation/registration_screen.dart';
import '../../features/doctor_link/presentation/doctor_link_screen.dart';
import '../../features/doctor_link/presentation/doctor_list_screen.dart';
import '../../features/prescriptions/presentation/doctor_prescriptions_screen.dart';
import '../../features/prescriptions/presentation/prescription_detail_screen.dart';
import '../../features/prescriptions/presentation/medication_detail_screen.dart';

import '../../core/widgets/logo.dart';

import '../../l10n/l10n_extension.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/register',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // lil hack to only show logo on base pages lol
          final isHome = state.matchedLocation == '/home';
          final isDoctorList = state.matchedLocation == '/my-doctors';
          final isProfile = state.matchedLocation == '/profile';
          final showAppBar = isHome || isDoctorList || isProfile;

          return Scaffold(
            appBar: showAppBar
                ? AppBar(
                    title: const AppLogo(),
                    centerTitle: true,
                    toolbarHeight: 60,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  )
                : null,
            body: navigationShell,
            extendBody: true,
            bottomNavigationBar: NativeGlassNavBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(index),
              tabs: [
                NativeGlassNavBarItem(label: context.l10n.home, symbol: 'house.fill'),
                NativeGlassNavBarItem(label: context.l10n.myDoctors, symbol: 'person.2.fill'),
                NativeGlassNavBarItem(label: context.l10n.profile, symbol: 'person.fill'),
              ],
              fallback: BottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (index) => navigationShell.goBranch(index),
                items: [
                  BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: context.l10n.home),
                  BottomNavigationBarItem(icon: const Icon(Icons.people_outline), label: context.l10n.myDoctors),
                  BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: context.l10n.profile),
                ],
              ),
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-doctors',
                builder: (context, state) => const DoctorListScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
      
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/doctor-prescriptions',
        builder: (context, state) => const DoctorPrescriptionsScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/prescription-details/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return PrescriptionDetailScreen(prescriptionId: id);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/medication-details/:medId',
        builder: (context, state) {
          final medId = state.pathParameters['medId']!;
          return MedicationDetailScreen(medicationId: medId);
        },
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/register',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/doctor-link',
        builder: (context, state) => const DoctorLinkScreen(),
      ),
    ],
  );
});
