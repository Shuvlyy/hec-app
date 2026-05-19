import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/mock_repositories.dart';
import '../../prescriptions/domain/medication.dart';

final homeMedicationsProvider = Provider<AsyncValue<List<Medication>>>((ref) {
  final prescriptionsAsync = ref.watch(mockPrescriptionsProvider);
  
  return prescriptionsAsync.whenData((prescriptions) {
    return prescriptions.expand((p) => p.medications).toList();
  });
});

final homeAdherenceRateProvider = Provider<AsyncValue<double>>((ref) {
  final medicationsAsync = ref.watch(homeMedicationsProvider);
  
  return medicationsAsync.whenData((medications) {
    if (medications.isEmpty) return 0.0;
    return medications.map((m) => m.adherenceRate).reduce((a, b) => a + b) / medications.length;
  });
});

final nextDoseProvider = Provider<AsyncValue<Medication?>>((ref) {
  final medicationsAsync = ref.watch(homeMedicationsProvider);
  
  return medicationsAsync.whenData((medications) {
    if (medications.isEmpty) return null;
    // For now, just return the first one as "next"
    return medications.first;
  });
});

final laterTodayMedicationsProvider = Provider<AsyncValue<List<Medication>>>((ref) {
  final medicationsAsync = ref.watch(homeMedicationsProvider);
  
  return medicationsAsync.whenData((medications) {
    if (medications.length <= 1) return [];
    return medications.skip(1).toList();
  });
});
