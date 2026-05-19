import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_cards.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/doctor_avatar.dart';
import '../../../core/utils/mock_repositories.dart';
import '../../../l10n/l10n_extension.dart';

class DoctorListScreen extends ConsumerWidget {
  const DoctorListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(mockPrescriptionsProvider);
    final doctor = ref.watch(mockDoctorProvider);

    return Scaffold(
      body: prescriptionsAsync.when(
        data: (prescriptions) {
          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            children: [
              Text(
                context.l10n.myDoctors,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro',
                ),
              ),
              const SizedBox(height: 24),
              AppCard(
                onTap: () => context.push('/doctor-prescriptions'),
                child: Column(
                  children: [
                    Row(
                      children: [
                        DoctorAvatar(name: doctor.name, radius: 30, fontSize: 18),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'SF Pro',
                                ),
                              ),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                  fontFamily: 'SF Pro',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                    const Gap(16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFF8F9FB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF007AFF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.medication, color: Colors.white, size: 14),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${prescriptions.length} prescriptions',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(context.l10n.error(err.toString()))),
      ),
    );
  }
}
