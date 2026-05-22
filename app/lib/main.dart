import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repill/routing/router.dart';
import 'package:repill/theme/app_theme.dart';
import 'package:repill/services/notification_service.dart';
import 'package:repill/providers/prescription_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:repill/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestPermissions();

  runApp(const ProviderScope(child: RePillApp()));
}

class RePillApp extends ConsumerWidget {
  const RePillApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Schedule notifications for initial data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final meds = ref.read(todayMedicationsProvider);
      NotificationService().scheduleAll(meds);
    });

    return MaterialApp.router(
      title: 'RePill',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
    );
  }
}
