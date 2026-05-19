import 'package:flutter/widgets.dart';
import '../../../l10n/l10n_extension.dart';

enum MedicationFrequency {
  onceDaily,
  twiceDaily,
  threeTimesDaily;

  String localized(BuildContext context) {
    switch (this) {
      case MedicationFrequency.onceDaily:
        return context.l10n.onceDaily;
      case MedicationFrequency.twiceDaily:
        return context.l10n.twiceDaily;
      case MedicationFrequency.threeTimesDaily:
        return context.l10n.threeTimesDaily;
    }
  }
}

enum MedicationTime {
  morning,
  evening,
  morningEvening,
  night;

  String localized(BuildContext context) {
    switch (this) {
      case MedicationTime.morning:
        return context.l10n.morning;
      case MedicationTime.evening:
        return context.l10n.evening;
      case MedicationTime.morningEvening:
        return context.l10n.morningEvening;
      case MedicationTime.night:
        return context.l10n.night;
    }
  }
}

class Medication {
  final String id;
  final String name;
  final String dosage;
  final MedicationFrequency frequency;
  final MedicationTime? time;
  final String reasonKey;
  final String instructionsKey;
  final double adherenceRate;
  final int refillsRemaining;
  final DateTime lastFilled;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.time,
    required this.reasonKey,
    required this.instructionsKey,
    required this.adherenceRate,
    required this.refillsRemaining,
    required this.lastFilled,
  });

  String localizedReason(BuildContext context) {
    switch (reasonKey) {
      case 'painRelief':
        return context.l10n.painRelief;
      case 'bloodPressure':
        return context.l10n.bloodPressure;
      case 'cholesterolHypertension':
        return context.l10n.cholesterolHypertension;
      default:
        return reasonKey;
    }
  }

  String localizedInstructions(BuildContext context) {
    switch (instructionsKey) {
      case 'takeAfterMeals':
        return context.l10n.takeAfterMeals;
      case 'takeInMorning':
        return context.l10n.takeInMorning;
      case 'takeAtNight':
        return context.l10n.takeAtNight;
      default:
        return instructionsKey;
    }
  }

  String localizedRenewalStatus(BuildContext context) {
    if (refillsRemaining == 0) {
      return context.l10n.noRefillsLeft;
    } else if (refillsRemaining == 1) {
      return context.l10n.refillLeft;
    } else {
      return context.l10n.refillsLeft(refillsRemaining.toString());
    }
  }
}
