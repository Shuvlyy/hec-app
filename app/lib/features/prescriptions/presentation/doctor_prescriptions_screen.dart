import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hec_app/core/widgets/logo.dart';
import 'package:intl/intl.dart';
import 'package:hec_app/core/widgets/app_cards.dart';
import 'package:hec_app/core/widgets/doctor_avatar.dart';
import 'package:hec_app/core/utils/mock_repositories.dart';
import 'package:hec_app/l10n/l10n_extension.dart';

class DoctorPrescriptionsScreen extends ConsumerWidget {
  const DoctorPrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(mockPrescriptionsProvider);
    final doctor = ref.watch(mockDoctorProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DoctorAvatar(name: doctor.name, radius: 16, fontSize: 12),
            const Gap(10),
            Text(
              doctor.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'SF Pro',
              ),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).appBarTheme.iconTheme?.color,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward, size: 24),
            onPressed: () {
              // TODO: Navigate to past prescriptions
            },
            tooltip: context.l10n.pastPrescriptions,
          ),
          const Gap(6),
        ],
      ),
      body: prescriptionsAsync.when(
        data: (prescriptions) {
          final doctorPrescriptions = prescriptions.where((p) => p.doctor.id == doctor.id).toList();
          final totalMedications = doctorPrescriptions.fold(0, (sum, p) => sum + p.medications.length);

          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.description_outlined, color: Colors.blue, size: 20),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            doctorPrescriptions.length.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            context.l10n.activePlans,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.medication_outlined, color: Colors.green, size: 20),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            totalMedications.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            context.l10n.medications,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              Text(
                context.l10n.prescriptions,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro',
                ),
              ),
              const SizedBox(height: 16),
              Column(
                spacing: 16,
                children: doctorPrescriptions.map((prescription) {
                  return AppCard(
                    onTap: () => context.push('/prescription-details/${prescription.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.description_outlined, color: Colors.blue, size: 20),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '#${prescription.id.toUpperCase()}',
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                  Text(
                                    DateFormat('MMMM d, yyyy').format(prescription.date),
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                context.l10n.active,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),
                        Row(
                          children: [
                            Icon(Icons.medication_outlined, size: 16, color: Colors.grey.shade600),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${prescription.medications.length} ${context.l10n.medications}: ${prescription.medications.map((m) => m.name).join(', ')}',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                  fontFamily: 'SF Pro',
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              
              const Gap(16),
              const Divider(),
              const Gap(16),

              // Doctor Info Card (Fancy Version) - Moved to bottom
              AppCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        DoctorAvatar(name: doctor.name, radius: 36, fontSize: 24),
                        const Gap(15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doctor.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  fontFamily: 'SF Pro',
                                ),
                              ),
                              Text(
                                doctor.specialty,
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  fontFamily: 'SF Pro',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(height: 1),
                    ),
                    
                    // Doctor Details List
                    Column(
                      children: [
                        _DoctorInfoRow(
                          icon: Icons.location_on_outlined,
                          label: doctor.workplace,
                        ),
                        const SizedBox(height: 10),
                        const _DoctorInfoRow(
                          icon: Icons.phone_outlined,
                          label: '+33 6 12 34 56 78',
                        ),
                        const SizedBox(height: 10),
                        _DoctorInfoRow(
                          icon: Icons.mail_outline,
                          label: '${doctor.name.toLowerCase().replaceAll('.', '').replaceAll(' ', '.')}@hospital.com',
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _DoctorActionButton(
                            onPressed: () {}, // TODO: Implement call
                            icon: Icons.phone,
                            label: context.l10n.call,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _DoctorActionButton(
                            onPressed: () {}, // TODO: Implement email
                            icon: Icons.mail,
                            label: context.l10n.emailDoctor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {}, // TODO: Open Doctolib
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0053B3), // Doctolib Blue
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 10),
                            Text(
                              context.l10n.bookOnDoctolib,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          );

        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text(context.l10n.error(err.toString()))),
      ),
    );
  }
}

class _DoctorInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DoctorInfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 13,
              fontFamily: 'SF Pro',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _DoctorActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const _DoctorActionButton({
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 13)),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue.shade700,
        side: BorderSide(color: Colors.blue.shade100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
