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
  String get prescriptions => 'Ordonnances';

  @override
  String get settings => 'Paramètres';

  @override
  String get linkDMP => 'Lien vers Dossier Médical Partagé';

  @override
  String get dmpImported => 'DMP lié avec succès';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Activer les rappels';

  @override
  String get aboutUs => 'À propos de nous';

  @override
  String get language => 'Langue';

  @override
  String get account => 'Compte';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

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
  String get doctorName => 'Nom du médecin';

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

  @override
  String get prescriptionRenewal => 'J\'ai renouvelé mon ordonnance';

  @override
  String get renewalRequired => 'Renouvellement nécessaire';

  @override
  String get medications => 'Médicaments';
}
