import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/providers/prescription_provider.dart';
import 'package:milo/models/prescription.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:milo/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class PrescriptionsPage extends ConsumerWidget {
  const PrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptions = [...ref.watch(prescriptionProvider)];
    prescriptions.sort((a, b) => a.endDate.compareTo(b.endDate));
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFFFF8C42), size: 32),
            onPressed: () => context.push('/prescriptions/add'),
          ),
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.prescriptions,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(8),
            Text(
              "Find all your current treatments and active prescriptions here.",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const Gap(32),
            ...prescriptions.map((p) => _buildPrescriptionCard(context, p)),
            const Gap(80),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionCard(BuildContext context, Prescription p) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = p.endDate.difference(now).inDays;
    final isExpiringSoon = difference <= 5;

    final cardColor = isExpiringSoon ? const Color(0xFFFFF1F1) : Colors.white;
    final borderColor = isExpiringSoon ? const Color(0xFFFF6B6B).withOpacity(0.3) : const Color(0xFFF7F2ED);

    return InkWell(
      onTap: () => context.push('/prescriptions/details/${p.id}'),
      borderRadius: BorderRadius.circular(24),
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getCategoryColor(p.category).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(_getCategoryIcon(p.category), color: _getCategoryColor(p.category)),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    p.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => context.push('/prescriptions/edit/${p.id}'),
                ),
              ],
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpiringSoon ? Colors.white : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isExpiringSoon ? const Color(0xFFFF6B6B).withOpacity(0.1) : Colors.transparent,
                ),
              ),
              child: Column(
                children: p.medications.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final m = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: idx == p.medications.length - 1 ? 0 : 12),
                    child: Row(
                      children: [
                        Icon(
                          _getMedicationIcon(p.category),
                          size: 20,
                          color: const Color(0xFFFF8C42),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            '${m.name} ${m.dosage}',
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                        const Gap(8),
                        Text(
                          m.frequency.toDisplayString(l10n),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const Gap(16),
            const Divider(height: 1),
            const Gap(16),
            if (!isExpiringSoon) ...[
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined, size: 20, color: Colors.grey),
                  const Gap(8),
                  Text(
                    'Valid until ${DateFormat('MMMM d, yyyy').format(p.endDate)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.error_outline, color: Color(0xFFFF6B6B), size: 24),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Warning",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: const Color(0xFFFF6B6B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          l10n.expiresInDays(difference, DateFormat('MMM d, yyyy').format(p.endDate)),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFFFF6B6B)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    ));
  }

  IconData _getMedicationIcon(String category) {
    switch (category) {
      case 'Diabetes':
        return Icons.medication_outlined;
      case 'Pain':
        return Icons.health_and_safety_outlined;
      case 'Neurology':
        return Icons.psychology_outlined;
      default:
        return Icons.link;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Diabetes':
        return Icons.medication;
      case 'Pain':
        return Icons.health_and_safety;
      case 'Neurology':
        return Icons.psychology;
      default:
        return Icons.medical_services;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Diabetes':
        return const Color(0xFFFF8C42);
      case 'Pain':
        return const Color(0xFFFFB347);
      case 'Neurology':
        return const Color(0xFFFF6B6B);
      default:
        return const Color(0xFFFF8C42);
    }
  }
}
