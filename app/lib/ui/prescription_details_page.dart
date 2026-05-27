import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/providers/prescription_provider.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milo/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:milo/theme/app_theme.dart';

class PrescriptionDetailsPage extends ConsumerWidget {
  final String prescriptionId;
  const PrescriptionDetailsPage({super.key, required this.prescriptionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptions = ref.watch(prescriptionProvider);
    final prescription = prescriptions.firstWhere((p) => p.id == prescriptionId);
    final l10n = AppLocalizations.of(context)!;
    
    final now = DateTime.now();
    final difference = prescription.endDate.difference(now).inDays;
    final isExpiringSoon = difference <= 5;
    final medCount = prescription.medications.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Prescription"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => context.push('/prescriptions/edit/${prescription.id}'),
          ),
          const Gap(8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title: Heading (24px)
            Text(
              prescription.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(8),
            
            // Count: Caption (14px)
            _buildChip(
              context, 
              "$medCount Medication${medCount > 1 ? 's' : ''}", 
              Colors.grey.shade100, 
              Colors.grey.shade700
            ),
            const Gap(32),

            if (isExpiringSoon) ...[
              _buildWarningCard(context, ref, prescription, difference, l10n),
              const Gap(32),
            ],
            
            // Section Title: Title (18px)
            Text(
              "Medications", 
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(16),
            ...prescription.medications.map((m) => _buildMedicationItem(context, m, l10n)),
            
            const Gap(32),
            const Divider(),
            const Gap(32),

            // Section Title: Title (18px)
            Text(
              "Validity", 
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(16),
            _buildInfoRow(context, Icons.person_outline, l10n.doctorName, prescription.doctorName),
            const Gap(16),
            _buildInfoRow(context, Icons.calendar_month_outlined, l10n.prescriptionEndDate, DateFormat('MMMM d, yyyy').format(prescription.endDate)),
            
            const Gap(40),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(BuildContext context, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildWarningCard(BuildContext context, WidgetRef ref, dynamic prescription, int difference, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFF6B6B).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.error_outline, color: Color(0xFFFF6B6B), size: 28),
              const Gap(12),
              Expanded(
                child: Text(
                  "Renewal Required",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xFFFF6B6B)),
                ),
              ),
            ],
          ),
          const Gap(12),
          Text(
            l10n.expiresInDays(difference, DateFormat('MMM d, yyyy').format(prescription.endDate)),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFFFF6B6B)),
          ),
          const Gap(20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showRenewDialog(context, ref, prescription.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6B6B),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("I renewed my prescription"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppTheme.primaryOrange, size: 24),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodySmall),
            Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildMedicationItem(BuildContext context, dynamic m, AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => context.push('/medication-details/${m.id}'),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.cardBorderColor),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.medication_outlined, color: AppTheme.primaryOrange),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(m.name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                    Text("${m.dosage} • ${m.frequency.toDisplayString(l10n)}", style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  void _showRenewDialog(BuildContext context, WidgetRef ref, String id) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    ).then((picked) {
      if (picked != null) {
        ref.read(prescriptionProvider.notifier).renewPrescription(id, picked);
      }
    });
  }
}
