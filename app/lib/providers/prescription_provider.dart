import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:milo/models/frequency.dart';
import 'package:milo/models/medication.dart';
import 'package:milo/models/prescription.dart';
import 'package:uuid/uuid.dart';

class PrescriptionNotifier extends StateNotifier<List<Prescription>> {
  PrescriptionNotifier() : super([]) {
    _loadMockData();
  }

  void _loadMockData() {
    final now = DateTime.now();
    final uuid = const Uuid();

    state = [
      Prescription(
        id: uuid.v4(),
        title: 'Diabète',
        doctorName: 'Dr. Martin',
        category: 'Diabetes',
        endDate: now.add(const Duration(days: 30)),
        medications: [
          Medication(
            id: uuid.v4(),
            name: 'Metformine',
            dosage: '1 pill',
            frequency: Frequency.onceADay,
            times: ['08:00'],
            instructions: 'Prendre au cours du repas',
          ),
        ],
      ),
      Prescription(
        id: uuid.v4(),
        title: 'Douleurs',
        doctorName: 'Dr. Durand',
        category: 'Pain',
        endDate: now.add(const Duration(days: 15)),
        medications: [
          Medication(
            id: uuid.v4(),
            name: 'Doliprane',
            dosage: '1 pill',
            frequency: Frequency.onceADay,
            times: ['12:00'],
            instructions: 'Prendre avec un verre d\'eau',
          ),
          Medication(
            id: uuid.v4(),
            name: 'Spasfon',
            dosage: '1/2 pill',
            frequency: Frequency.onceADay,
            times: ['12:00'],
            instructions: 'En cas de spasms',
          ),
        ],
      ),
      Prescription(
        id: uuid.v4(),
        title: 'Neurologie / Thyroïde',
        doctorName: 'Dr. Petit',
        category: 'Neurology',
        endDate: now.add(const Duration(days: 3)),
        medications: [
          Medication(
            id: uuid.v4(),
            name: 'Levothyrox',
            dosage: '1 pill',
            frequency: Frequency.onceADay,
            times: ['20:00'],
            instructions: 'À jeun le matin (ou selon prescription)',
          ),
        ],
      ),
    ];
  }

  void addPrescription(Prescription prescription) {
    // Check if it's an update
    final index = state.indexWhere((p) => p.id == prescription.id);
    if (index != -1) {
      state = [
        for (final p in state)
          if (p.id == prescription.id) prescription else p
      ];
    } else {
      state = [...state, prescription];
    }
  }

  void deletePrescription(String id) {
    state = state.where((p) => p.id != id).toList();
  }

  void renewPrescription(String id, DateTime newEndDate) {
    state = [
      for (final p in state)
        if (p.id == id) p.copyWith(endDate: newEndDate) else p
    ];
  }

  void updateMedicationStatus(String medicationId, bool isTaken) {
    state = [
      for (final prescription in state)
        prescription.copyWith(
          medications: [
            for (final med in prescription.medications)
              if (med.id == medicationId) med.copyWith(isTaken: isTaken) else med
          ],
        )
    ];
  }
}

final prescriptionProvider = StateNotifierProvider<PrescriptionNotifier, List<Prescription>>((ref) {
  return PrescriptionNotifier();
});

final todayMedicationsProvider = Provider<List<Medication>>((ref) {
  final prescriptions = ref.watch(prescriptionProvider);
  final allMeds = prescriptions.expand((p) => p.medications).toList();
  // Filter for today (for simplicity, we assume all onceADay/twiceADay are for today)
  return allMeds.where((m) => m.frequency != Frequency.asNeeded).toList()
    ..sort((a, b) {
      final aTime = a.times.isNotEmpty ? a.times.first : '';
      final bTime = b.times.isNotEmpty ? b.times.first : '';
      return aTime.compareTo(bTime);
    });
});
