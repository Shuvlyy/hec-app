import 'package:milo/models/medication.dart';

class Prescription {
  final String id;
  final String title;
  final String doctorName;
  final DateTime endDate;
  final List<Medication> medications;
  final String category; // e.g., "Diabetes", "Neurology"

  Prescription({
    required this.id,
    required this.title,
    required this.doctorName,
    required this.endDate,
    required this.medications,
    required this.category,
  });

  Prescription copyWith({
    String? id,
    String? title,
    String? doctorName,
    DateTime? endDate,
    List<Medication>? medications,
    String? category,
  }) {
    return Prescription(
      id: id ?? this.id,
      title: title ?? this.title,
      doctorName: doctorName ?? this.doctorName,
      endDate: endDate ?? this.endDate,
      medications: medications ?? this.medications,
      category: category ?? this.category,
    );
  }
}
