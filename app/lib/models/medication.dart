import 'package:milo/models/frequency.dart';

class Medication {
  final String id;
  final String name;
  final String dosage;
  final Frequency frequency;
  final List<String> times; // List of "HH:mm"
  final String instructions;
  final bool isTaken;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.times,
    required this.instructions,
    this.isTaken = false,
  });

  Medication copyWith({
    String? id,
    String? name,
    String? dosage,
    Frequency? frequency,
    List<String>? times,
    String? instructions,
    bool? isTaken,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      times: times ?? this.times,
      instructions: instructions ?? this.instructions,
      isTaken: isTaken ?? this.isTaken,
    );
  }
}
