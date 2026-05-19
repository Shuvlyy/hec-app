import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hec_app/core/localization/locale_provider.dart';
import 'package:hec_app/core/widgets/app_buttons.dart';
import 'package:hec_app/l10n/l10n_extension.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.profile,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'SF Pro',
              ),
            ),
            const Gap(32),
            AppPrimaryButton(
              text: context.l10n.english,
              onPressed: () async {
                ref.read(localeProvider.notifier).setLocale(const Locale('en'));
                context.go('/register');
              },
            ),
            const Gap(16),
            AppPrimaryButton(
              text: context.l10n.french,
              onPressed: () async {
                ref.read(localeProvider.notifier).setLocale(const Locale('fr'));
                context.go('/register');
              },
            ),
          ],
        ),
      ),
    );
  }
}
