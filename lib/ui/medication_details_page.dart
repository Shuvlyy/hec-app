import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/providers/prescription_provider.dart';
import 'package:gap/gap.dart';
import 'package:milo/l10n/app_localizations.dart';

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
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                _getImageUrl(med.name),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 64, color: Color(0xFFFF8C42)),
              ),
            ),
            const Gap(32),
            Text(
              med.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              med.dosage,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Gap(32),
            _buildDetailRow(context, Icons.repeat, l10n.frequency, med.frequency.toDisplayString(l10n)),
            const Gap(16),
            _buildDetailRow(context, Icons.access_time, l10n.timeOptional, med.times.isEmpty ? '--:--' : med.times.join(', ')),
            const Gap(32),
            const Divider(),
            const Gap(32),
            if (med.details.isNotEmpty) ...[
              Text(
                l10n.details,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Gap(12),
              Text(
                med.details,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
              const Gap(32),
            ],
            Text(
              l10n.instructions, 
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(12),
            Text(
              med.instructions,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  String _getImageUrl(String name) {
    switch (name.toLowerCase()) {
      case 'amlodipine':
        return 'https://5.imimg.com/data5/SELLER/Default/2022/9/XD/NQ/YM/123462026/amlodipine-tablet-10-mg-500x500.jpg';
      case 'empagliflozin (jardiance)':
        return 'https://pro.boehringer-ingelheim.com/ca/products/jardiance/sites/default/files/2024-10/JARDIANCE%C2%AE%20package%20shot.jpg';
      case 'ezetimibe':
        return 'https://benu.be/cdn/shop/files/b6cf3ad2f73c86afe48e09c5b7e7547111644c2f_2_3577038.jpg?v=1771943900&width=500';
      case 'atorvastatin':
        return 'https://images.apollo247.in/pub/media/catalog/product/a/t/ato0053_1_1.jpg';
      default:
        return 'https://images.unsplash.com/photo-1471864190281-a93a307246de?q=80&w=2072&auto=format&fit=crop';
    }
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color(0xFFFF8C42)),
        ),
        const Gap(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label, 
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              value, 
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
