// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Milo';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get prescriptions => 'Prescriptions';

  @override
  String get profile => 'Profil';

  @override
  String dosesLeft(int count) {
    return 'Il vous reste $count prises aujourd\'hui.';
  }

  @override
  String get allDosesTaken =>
      'Vous avez pris tous vos médicaments pour aujourd\'hui. Félicitations !';

  @override
  String get taken => 'Pris';

  @override
  String get later => 'Plus tard';

  @override
  String expiresInDays(int days, String date) {
    return 'Expire dans $days jours ($date)';
  }

  @override
  String get scanMyPrescription => 'Scanner mon ordonnance';

  @override
  String get aiScanDescription =>
      'Notre IA extrait automatiquement vos médicaments.';

  @override
  String get prescriptionTitle => 'Titre de l\'ordonnance';

  @override
  String get prescriptionEndDate => 'Date de fin de l\'ordonnance';

  @override
  String get medicationName => 'Nom du médicament';

  @override
  String get dosage => 'Dosage';

  @override
  String get frequency => 'Fréquence';

  @override
  String get timeOptional => 'Heure (Optionnel)';

  @override
  String get savePrescription => 'Enregistrer l\'ordonnance';

  @override
  String get onceADay => '1 fois / jour';

  @override
  String get twiceADay => '2 fois / jour';

  @override
  String get threeTimesADay => '3 fois / jour';

  @override
  String get onceAWeek => '1 fois / semaine';

  @override
  String get asNeeded => 'Si besoin';

  @override
  String get takeWithMeal => 'Prendre au cours du repas';

  @override
  String get newPrescription => 'Nouvelle Ordonnance';

  @override
  String get editPrescription => 'Modifier l\'Ordonnance';

  @override
  String get medicationDetails => 'Détails du Médicament';

  @override
  String get instructions => 'Instructions';

  @override
  String get noMedications => 'Aucun médicament prévu pour aujourd\'hui.';
}
