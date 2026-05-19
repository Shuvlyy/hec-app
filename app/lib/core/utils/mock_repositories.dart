import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/doctor_link/domain/doctor.dart';
import '../../features/prescriptions/domain/medication.dart';
import '../../features/prescriptions/domain/prescription.dart';

final mockDoctorProvider = Provider<Doctor>((ref) {
  return Doctor(
    id: 'doc1',
    name: 'Dr. Sophie Ammani',
    specialty: 'Cardiologist',
    workplace: 'St. Mary\'s Hospital',
  );
});

final mockPrescriptionsProvider = AsyncNotifierProvider<PrescriptionsNotifier, List<Prescription>>(() {
  return PrescriptionsNotifier();
});

class PrescriptionsNotifier extends AsyncNotifier<List<Prescription>> {
  @override
  Future<List<Prescription>> build() async {
    await Future.delayed(const Duration(seconds: 1)); // simulate delay
    
    final doctor = ref.read(mockDoctorProvider);
    
    return [
      Prescription(
        id: 'p1',
        doctor: doctor,
        date: DateTime.now().subtract(const Duration(days: 2)),
        medications: [
          Medication(
            id: 'm1',
            name: 'Atorvastatin',
            dosage: '20 mg',
            frequency: MedicationFrequency.onceDaily,
            time: MedicationTime.night,
            reasonKey: 'cholesterolHypertension',
            instructionsKey: 'takeAtNight',
            adherenceRate: 0.94,
            refillsRemaining: 2,
            lastFilled: DateTime(2023, 10, 12),
          ),
          Medication(
            id: 'm2',
            name: 'Doliprane',
            dosage: '1000 mg',
            frequency: MedicationFrequency.twiceDaily,
            time: MedicationTime.morningEvening,
            reasonKey: 'painRelief',
            instructionsKey: 'takeAfterMeals',
            adherenceRate: 0.85,
            refillsRemaining: 1,
            lastFilled: DateTime(2023, 11, 5),
          ),
        ],
      ),
      Prescription(
        id: 'p2',
        doctor: doctor,
        date: DateTime.now().subtract(const Duration(days: 15)),
        medications: [
          Medication(
            id: 'm3',
            name: 'Lisinopril',
            dosage: '10 mg',
            frequency: MedicationFrequency.onceDaily,
            time: MedicationTime.morning,
            reasonKey: 'bloodPressure',
            instructionsKey: 'takeInMorning',
            adherenceRate: 1.0,
            refillsRemaining: 0,
            lastFilled: DateTime(2023, 12, 1),
          ),
        ],
      ),
    ];
  }
}
