// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'AppName';

  @override
  String get home => 'Accueil';

  @override
  String get myDoctors => 'Mes médecins';

  @override
  String get profile => 'Profil';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String error(String message) {
    return 'Erreur: $message';
  }

  @override
  String get active => 'Actif';

  @override
  String get taken => 'Pris';

  @override
  String dosageTaken(String dosage) {
    return '$dosage • Pris';
  }

  @override
  String get onceDaily => 'Une fois par jour';

  @override
  String get twiceDaily => '2 fois par jour';

  @override
  String get threeTimesDaily => '3 fois par jour';

  @override
  String get morning => 'Matin';

  @override
  String get evening => 'Soir';

  @override
  String get morningEvening => 'Matin, Soir';

  @override
  String get night => 'Nuit';

  @override
  String get painRelief => 'Soulagement de la douleur';

  @override
  String get bloodPressure => 'Tension artérielle';

  @override
  String get cholesterolHypertension =>
      'Utilisé pour traiter le cholestérol élevé et gérer l\'hypertension.';

  @override
  String get takeAfterMeals => 'À prendre après les repas.';

  @override
  String get takeInMorning => 'À prendre le matin.';

  @override
  String get takeAtNight => 'À prendre le soir, avec ou sans nourriture.';

  @override
  String get noRefillsLeft => 'Plus de renouvellement';

  @override
  String get refillLeft => '1 renouvellement restant';

  @override
  String refillsLeft(String count) {
    return '$count renouvellements restants';
  }

  @override
  String get confirmDoseTaken => 'Confirmer la dose prise';

  @override
  String get adherenceRate => 'Taux d\'observance';

  @override
  String lastFilled(String date) {
    return 'Dernier remplissage: $date';
  }

  @override
  String get goodMorning => 'Bonjour,';

  @override
  String get yourProgress => 'VOTRE PROGRESSION';

  @override
  String get excellent => 'Excellent';

  @override
  String get onTrack => 'Sur la bonne voie';

  @override
  String get good => 'Bon';

  @override
  String get upNext => 'À venir';

  @override
  String get now => 'Maintenant';

  @override
  String get doseRecorded => 'Dose enregistrée. Votre médecin a été prévenu.';

  @override
  String get laterToday => 'Plus tard aujourd\'hui';

  @override
  String get scheduled => 'Programmé';

  @override
  String get allMedicationsTaken =>
      'Tous les médicaments pris pour aujourd\'hui !';

  @override
  String get connectWithDoctors => 'Connectez-vous avec vos médecins';

  @override
  String get keepMedicalTeamUpdated => 'Tenez votre équipe médicale informée';

  @override
  String get creatingAccount => 'Un instant, nous créons votre compte...';

  @override
  String get howShouldWeCallYou => 'Comment devrions-nous vous appeler ?';

  @override
  String get fullName => 'Nom complet';

  @override
  String get fullNameHint => 'ex. Alice Dupont';

  @override
  String registrationGreeting(String name) {
    return 'D\'accord $name !\nSur quelle adresse e-mail devons-nous créer votre compte ?';
  }

  @override
  String get email => 'E-mail';

  @override
  String get emailHint => 'ex. alice.dupont@exemple.com';

  @override
  String get passwordTitle => 'Maintenant, configurez votre mot de passe.';

  @override
  String get password => 'Mot de passe';

  @override
  String get passwordHint => 'Min. 8 caractères';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? Connectez-vous';

  @override
  String get selectRole =>
      'Veuillez sélectionner votre rôle pour continuer la configuration de votre profil';

  @override
  String get doctor => 'Médecin';

  @override
  String get patient => 'Patient';

  @override
  String get enterDoctorId => 'Saisir l\'identifiant du médecin';

  @override
  String get doctorId => 'ID du médecin';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirm => 'Confirmer';

  @override
  String get linkWithDoctor => 'Lier avec votre médecin';

  @override
  String get linkWithDoctorDescription =>
      'Connectez-vous avec votre médecin pour recevoir en toute sécurité des ordonnances, des plans de soins personnalisés et une communication directe avec votre professionnel de santé.';

  @override
  String get scanQrCode => 'Scanner le QR code';

  @override
  String get proceedManually => 'Procéder manuellement';

  @override
  String get doctorFound => 'Médecin trouvé !';

  @override
  String get confirmAndLink => 'Confirmer et lier';

  @override
  String get rescanQrCode => 'Rescanner le QR code';

  @override
  String get frequency => 'Fréquence';

  @override
  String get scheduledTime => 'Heure prévue';

  @override
  String get reasonForUse => 'Raison d\'utilisation';

  @override
  String get specialInstructions => 'Instructions spéciales';

  @override
  String get takeWithFood => 'À prendre pendant le repas';

  @override
  String get drinkFullGlassWater => 'Boire un grand verre d\'eau';

  @override
  String refillsRemaining(String count) {
    return '$count Renouvellements restants';
  }

  @override
  String get activePlans => 'Plans actifs';

  @override
  String get medications => 'Médicaments';

  @override
  String get prescriptions => 'Ordonnances';

  @override
  String get pastPrescriptions => 'Anciennes ordonnances';

  @override
  String get call => 'Appeler';

  @override
  String get emailDoctor => 'E-mail';

  @override
  String get bookOnDoctolib => 'Réserver sur Doctolib';

  @override
  String get prescribedMedications => 'Médicaments prescrits';
}
