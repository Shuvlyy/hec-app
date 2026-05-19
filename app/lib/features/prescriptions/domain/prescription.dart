import 'medication.dart';
import '../../doctor_link/domain/doctor.dart';

class Prescription {
  final String id;
  final Doctor doctor;
  final DateTime date;
  final List<Medication> medications;

  Prescription({
    required this.id,
    required this.doctor,
    required this.date,
    required this.medications,
  });
}
