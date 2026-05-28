import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/l10n/app_localizations.dart';
import 'package:milo/models/frequency.dart';
import 'package:milo/models/medication.dart';
import 'package:milo/models/prescription.dart';
import 'package:milo/providers/prescription_provider.dart';
import 'package:milo/theme/app_theme.dart';
import 'package:uuid/uuid.dart';
import 'package:gap/gap.dart';

import 'package:milo/providers/locale_provider.dart';
import 'package:milo/providers/dmp_provider.dart';
import 'package:milo/providers/notification_settings_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isLoadingDMP = false;

  Future<void> _simulateDMPImport() async {
    final isDMPLinked = ref.read(dmpLinkedProvider);
    if (isDMPLinked || _isLoadingDMP) return;

    setState(() {
      _isLoadingDMP = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    const uuid = Uuid();
    final now = DateTime.now();
    
    final newPrescriptions = [
      Prescription(
        id: uuid.v4(),
        title: 'Hypertension',
        doctorName: 'Dr. Legrand',
        category: 'Cardiology',
        endDate: now.add(const Duration(days: 2)),
        medications: [
          Medication(
            id: uuid.v4(),
            name: 'Amlodipine',
            dosage: '2 pills',
            frequency: Frequency.onceADay,
            times: ['09:00'],
            instructions: 'Take with food',
            details: 'Amlodipine is a calcium channel blocker used to treat high blood pressure (hypertension) and chest pain (angina). By relaxing blood vessels, it improves blood flow and lowers blood pressure, reducing the workload on your heart. Regular use helps prevent future heart disease, heart attacks, and strokes.'
          ),
        ],
      ),
      Prescription(
        id: uuid.v4(),
        title: 'Cholesterol',
        doctorName: 'Dr. Legrand',
        category: 'Cardiology',
        endDate: now.add(const Duration(days: 24)),
        medications: [
          Medication(
            id: uuid.v4(),
            name: 'Atorvastatin',
            dosage: '1 pill',
            frequency: Frequency.onceADay,
            times: ['22:00'],
            instructions: 'Take just before sleep, with a glass of water.',
            details: 'Atorvastatin belongs to a group of medicines called statins. It is used to lower cholesterol if you have been diagnosed with high cholesterol. It is also taken to prevent heart disease, including heart attacks and strokes. It works by reducing the amount of cholesterol made by the liver.'
          ),
          Medication(
            id: uuid.v4(),
            name: 'Ezetimibe',
            dosage: '1 pill',
            frequency: Frequency.onceADay,
            times: ['14:00'],
            instructions: 'Can be taken with or without food.',
            details: 'Ezetimibe is used to lower cholesterol by reducing the amount of cholesterol your body absorbs from the food you eat. It is often prescribed alongside a statin when a statin alone does not lower cholesterol levels enough.'
          ),
        ],
      ),
    ];

    for (final p in newPrescriptions) {
      ref.read(prescriptionProvider.notifier).addPrescription(p);
    }

    if (mounted) {
      ref.read(dmpLinkedProvider.notifier).state = true;
      setState(() {
        _isLoadingDMP = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.dmpImported),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.green.shade600,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDMPLinked = ref.watch(dmpLinkedProvider);
    final notificationsEnabled = ref.watch(notificationSettingsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.settings,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(32),
            
            // DMP Link Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: (isDMPLinked || _isLoadingDMP) ? null : _simulateDMPImport,
                style: FilledButton.styleFrom(
                  backgroundColor: isDMPLinked ? Colors.green.shade50 : AppTheme.primaryOrange,
                  foregroundColor: isDMPLinked ? Colors.green : Colors.white,
                  disabledBackgroundColor: isDMPLinked ? Colors.green.shade50 : AppTheme.primaryOrange.withOpacity(0.6),
                  disabledForegroundColor: isDMPLinked ? Colors.green : Colors.white70,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: isDMPLinked ? BorderSide(color: Colors.green.shade200) : BorderSide.none,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (_isLoadingDMP)
                      const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    else
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              l10n.linkDMP,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(isDMPLinked ? CupertinoIcons.check_mark_circled : CupertinoIcons.chevron_right, size: 22),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            const Gap(40),
            _buildSectionTitle(l10n.notifications),
            _buildSettingsCard(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => ref.read(notificationSettingsProvider.notifier).state = !notificationsEnabled,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.bell, color: CupertinoColors.systemGrey),
                        const Gap(16),
                        Expanded(
                          child: Text(
                            l10n.enableNotifications,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        CupertinoSwitch(
                          value: notificationsEnabled,
                          activeColor: AppTheme.primaryOrange,
                          onChanged: (value) {
                            ref.read(notificationSettingsProvider.notifier).state = value;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const Gap(32),
            _buildSectionTitle('App'),
            _buildSettingsCard(
              child: Column(
                children: [
                  _buildCupertinoLikeTile(
                    icon: CupertinoIcons.globe,
                    title: l10n.language,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ref.watch(localeProvider).languageCode == 'fr' ? 'Français' : 'English',
                          style: const TextStyle(color: CupertinoColors.inactiveGray),
                        ),
                        const Gap(8),
                        const Icon(CupertinoIcons.chevron_right, size: 16, color: CupertinoColors.inactiveGray),
                      ],
                    ),
                    onTap: () => _showLanguagePicker(context, ref),
                  ),
                  const Divider(indent: 56, height: 1, color: AppTheme.cardBorderColor),
                  _buildCupertinoLikeTile(
                    icon: CupertinoIcons.info,
                    title: l10n.aboutUs,
                    trailing: const Icon(CupertinoIcons.chevron_right, size: 16, color: CupertinoColors.inactiveGray),
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('Milo'),
                          content: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Version 1.0.0'),
                              Gap(12),
                              Text('Milo is your daily companion for medical adherence, helping you manage your prescriptions with ease and intelligence.'),
                            ],
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              child: const Text('Licenses'),
                              onPressed: () {
                                Navigator.pop(context);
                                showLicensePage(
                                  context: context,
                                  applicationName: 'Milo',
                                  applicationVersion: '1.0.0',
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Divider(indent: 56, height: 1, color: AppTheme.cardBorderColor),
                  _buildCupertinoLikeTile(
                    icon: CupertinoIcons.shield,
                    title: l10n.privacyPolicy,
                    trailing: const Icon(CupertinoIcons.chevron_right, size: 16, color: CupertinoColors.inactiveGray),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Gap(100), // Space for bottom bar
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoLikeTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(icon, size: 22, color: CupertinoColors.systemGrey),
              const Gap(16),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        final currentLocale = ref.watch(localeProvider);
        return CupertinoAlertDialog(
          title: Text(AppLocalizations.of(context)!.language),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                ref.read(localeProvider.notifier).setLocale(const Locale('fr'));
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Français',
                    style: TextStyle(
                      color: CupertinoColors.label,
                      fontWeight: FontWeight.normal,
                      fontSize: 26
                    ),
                  ),
                  if (currentLocale.languageCode == 'fr') ...[
                    const Gap(8),
                    const Icon(CupertinoIcons.check_mark, size: 18, color: AppTheme.primaryOrange),
                  ],
                ],
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                ref.read(localeProvider.notifier).setLocale(const Locale('en'));
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'English',
                    style: TextStyle(
                      color: CupertinoColors.label,
                      fontWeight: FontWeight.normal,
                      fontSize: 26
                    ),
                  ),
                  if (currentLocale.languageCode == 'en') ...[
                    const Gap(8),
                    const Icon(CupertinoIcons.check_mark, size: 18, color: AppTheme.primaryOrange),
                  ],
                ],
              ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: CupertinoColors.systemGrey,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.2,
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.cardBorderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: child,
      ),
    );
  }
}
