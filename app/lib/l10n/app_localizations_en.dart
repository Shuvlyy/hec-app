// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'AppName';

  @override
  String get home => 'Home';

  @override
  String get myDoctors => 'My Doctors';

  @override
  String get profile => 'Profile';

  @override
  String get english => 'English';

  @override
  String get french => 'French';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get active => 'Active';

  @override
  String get taken => 'Taken';

  @override
  String dosageTaken(String dosage) {
    return '$dosage • Taken';
  }

  @override
  String get onceDaily => 'Once daily';

  @override
  String get twiceDaily => 'Twice daily';

  @override
  String get threeTimesDaily => 'Three times daily';

  @override
  String get morning => 'Morning';

  @override
  String get evening => 'Evening';

  @override
  String get morningEvening => 'Morning, Evening';

  @override
  String get night => 'Night';

  @override
  String get painRelief => 'Pain relief';

  @override
  String get bloodPressure => 'Blood pressure';

  @override
  String get cholesterolHypertension =>
      'Used to treat high cholesterol and manage hypertension.';

  @override
  String get takeAfterMeals => 'Take after meals.';

  @override
  String get takeInMorning => 'Take in the morning.';

  @override
  String get takeAtNight => 'Take at night, with or without food.';

  @override
  String get noRefillsLeft => 'No refills left';

  @override
  String get refillLeft => '1 refill left';

  @override
  String refillsLeft(String count) {
    return '$count refills left';
  }

  @override
  String get confirmDoseTaken => 'Confirm dose taken';

  @override
  String get adherenceRate => 'Adherence rate';

  @override
  String lastFilled(String date) {
    return 'Last filled: $date';
  }

  @override
  String get goodMorning => 'Good morning,';

  @override
  String get yourProgress => 'YOUR PROGRESS';

  @override
  String get excellent => 'Excellent';

  @override
  String get onTrack => 'On track';

  @override
  String get good => 'Good';

  @override
  String get upNext => 'Up next';

  @override
  String get now => 'Now';

  @override
  String get doseRecorded => 'Dose recorded. Your doctor has been notified.';

  @override
  String get laterToday => 'Later today';

  @override
  String get scheduled => 'Scheduled';

  @override
  String get allMedicationsTaken => 'All medications taken for today!';

  @override
  String get connectWithDoctors => 'Connect with your doctors';

  @override
  String get keepMedicalTeamUpdated => 'Keep your medical team updated';

  @override
  String get creatingAccount => 'One moment, we\'re creating your account...';

  @override
  String get howShouldWeCallYou => 'How should we call you?';

  @override
  String get fullName => 'Full name';

  @override
  String get fullNameHint => 'e.g. Alice Smith';

  @override
  String registrationGreeting(String name) {
    return 'Okay $name!\nWhich email address should we use to create your account?';
  }

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'e.g. alice.smith@example.com';

  @override
  String get passwordTitle => 'Now, set up your password.';

  @override
  String get password => 'Password';

  @override
  String get passwordHint => 'Min. 8 characters';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get selectRole =>
      'Please select your role to continue setting up your profile';

  @override
  String get doctor => 'Doctor';

  @override
  String get patient => 'Patient';

  @override
  String get enterDoctorId => 'Enter doctor ID';

  @override
  String get doctorId => 'Doctor ID';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get linkWithDoctor => 'Link with your doctor';

  @override
  String get linkWithDoctorDescription =>
      'Connect with your doctor to securely receive prescriptions, personalized care plans, and direct communication with your healthcare provider.';

  @override
  String get scanQrCode => 'Scan QR code';

  @override
  String get proceedManually => 'Proceed manually';

  @override
  String get doctorFound => 'Doctor found!';

  @override
  String get confirmAndLink => 'Confirm and link';

  @override
  String get rescanQrCode => 'Rescan QR code';

  @override
  String get frequency => 'Frequency';

  @override
  String get scheduledTime => 'Scheduled time';

  @override
  String get reasonForUse => 'Reason for use';

  @override
  String get specialInstructions => 'Special instructions';

  @override
  String get takeWithFood => 'Take with food';

  @override
  String get drinkFullGlassWater => 'Drink a full glass of water';

  @override
  String refillsRemaining(String count) {
    return '$count refills remaining';
  }

  @override
  String get activePlans => 'Active plans';

  @override
  String get medications => 'Medications';

  @override
  String get prescriptions => 'Prescriptions';

  @override
  String get pastPrescriptions => 'Past prescriptions';

  @override
  String get call => 'Call';

  @override
  String get emailDoctor => 'Email';

  @override
  String get bookOnDoctolib => 'Book on Doctolib';

  @override
  String get prescribedMedications => 'Prescribed medications';
}
