// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Milo';

  @override
  String get today => 'Today';

  @override
  String get prescriptions => 'Prescriptions';

  @override
  String get settings => 'Settings';

  @override
  String get linkDMP => 'Link to Dossier Médical Partagé';

  @override
  String get dmpImported => 'DMP successfully linked';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Enable reminders';

  @override
  String get aboutUs => 'About us';

  @override
  String get language => 'Language';

  @override
  String get account => 'Account';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String dosesLeft(int count) {
    return 'You have $count doses left today.';
  }

  @override
  String get allDosesTaken =>
      'You have taken all your medicine for today. Congratulations!';

  @override
  String get taken => 'Taken';

  @override
  String get later => 'Later';

  @override
  String expiresInDays(int days, String date) {
    return 'Expires in $days days ($date)';
  }

  @override
  String get scanMyPrescription => 'Scan my prescription';

  @override
  String get aiScanDescription =>
      'Our AI automatically extracts your medications.';

  @override
  String get doctorName => 'Doctor\'s Name';

  @override
  String get prescriptionTitle => 'Prescription Title';

  @override
  String get prescriptionEndDate => 'Prescription end date';

  @override
  String get medicationName => 'Medication name';

  @override
  String get dosage => 'Dosage';

  @override
  String get frequency => 'Frequency';

  @override
  String get timeOptional => 'Time (Optional)';

  @override
  String get savePrescription => 'Save prescription';

  @override
  String get onceADay => '1 time / day';

  @override
  String get twiceADay => '2 times / day';

  @override
  String get threeTimesADay => '3 times / day';

  @override
  String get onceAWeek => '1 time / week';

  @override
  String get asNeeded => 'As needed';

  @override
  String get takeWithMeal => 'Take during a meal';

  @override
  String get newPrescription => 'New Prescription';

  @override
  String get editPrescription => 'Edit Prescription';

  @override
  String get medicationDetails => 'Medication Details';

  @override
  String get details => 'Details';

  @override
  String get instructions => 'Instructions';

  @override
  String get noActivePrescriptions => 'No active prescriptions found.';

  @override
  String get noPrescriptionsHome =>
      'No medications scheduled. Add a prescription to begin!';

  @override
  String get noMedications => 'No medications scheduled for today.';

  @override
  String get prescriptionRenewal => 'I renewed my prescription';

  @override
  String get renewalRequired => 'Renewal required';

  @override
  String get medications => 'Medications';
}
