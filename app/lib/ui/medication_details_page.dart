import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repill/providers/prescription_provider.dart';
import 'package:gap/gap.dart';
import 'package:repill/l10n/app_localizations.dart';

class MedicationDetailsPage extends ConsumerWidget {
  final String medicationId;
  const MedicationDetailsPage({super.key, required this.medicationId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptions = ref.watch(prescriptionProvider);
    final med = prescriptions
        .expand((p) => p.medications)
        .firstWhere((m) => m.id == medicationId);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.medicationDetails),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.image, size: 64, color: Colors.white),
            ),
            const Gap(32),
            Text(
              med.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              med.dosage,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
            ),
            const Gap(32),
            _buildDetailRow(Icons.repeat, l10n.frequency, med.frequency.toDisplayString(l10n)),
            const Gap(16),
            _buildDetailRow(Icons.access_time, l10n.timeOptional, med.time ?? '--:--'),
            const Gap(32),
            const Divider(),
            const Gap(32),
            Text(l10n.instructions, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Gap(12),
            Text(
              med.instructions,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFF0066AA)),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
