import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'AppName'**
  String get appName;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @myDoctors.
  ///
  /// In en, this message translates to:
  /// **'My Doctors'**
  String get myDoctors;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String error(String message);

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @taken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get taken;

  /// No description provided for @dosageTaken.
  ///
  /// In en, this message translates to:
  /// **'{dosage} • Taken'**
  String dosageTaken(String dosage);

  /// No description provided for @onceDaily.
  ///
  /// In en, this message translates to:
  /// **'Once daily'**
  String get onceDaily;

  /// No description provided for @twiceDaily.
  ///
  /// In en, this message translates to:
  /// **'Twice daily'**
  String get twiceDaily;

  /// No description provided for @threeTimesDaily.
  ///
  /// In en, this message translates to:
  /// **'Three times daily'**
  String get threeTimesDaily;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @morningEvening.
  ///
  /// In en, this message translates to:
  /// **'Morning, Evening'**
  String get morningEvening;

  /// No description provided for @night.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get night;

  /// No description provided for @painRelief.
  ///
  /// In en, this message translates to:
  /// **'Pain relief'**
  String get painRelief;

  /// No description provided for @bloodPressure.
  ///
  /// In en, this message translates to:
  /// **'Blood pressure'**
  String get bloodPressure;

  /// No description provided for @cholesterolHypertension.
  ///
  /// In en, this message translates to:
  /// **'Used to treat high cholesterol and manage hypertension.'**
  String get cholesterolHypertension;

  /// No description provided for @takeAfterMeals.
  ///
  /// In en, this message translates to:
  /// **'Take after meals.'**
  String get takeAfterMeals;

  /// No description provided for @takeInMorning.
  ///
  /// In en, this message translates to:
  /// **'Take in the morning.'**
  String get takeInMorning;

  /// No description provided for @takeAtNight.
  ///
  /// In en, this message translates to:
  /// **'Take at night, with or without food.'**
  String get takeAtNight;

  /// No description provided for @noRefillsLeft.
  ///
  /// In en, this message translates to:
  /// **'No refills left'**
  String get noRefillsLeft;

  /// No description provided for @refillLeft.
  ///
  /// In en, this message translates to:
  /// **'1 refill left'**
  String get refillLeft;

  /// No description provided for @refillsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} refills left'**
  String refillsLeft(String count);

  /// No description provided for @confirmDoseTaken.
  ///
  /// In en, this message translates to:
  /// **'Confirm dose taken'**
  String get confirmDoseTaken;

  /// No description provided for @adherenceRate.
  ///
  /// In en, this message translates to:
  /// **'Adherence rate'**
  String get adherenceRate;

  /// No description provided for @lastFilled.
  ///
  /// In en, this message translates to:
  /// **'Last filled: {date}'**
  String lastFilled(String date);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning,'**
  String get goodMorning;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'YOUR PROGRESS'**
  String get yourProgress;

  /// No description provided for @excellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get excellent;

  /// No description provided for @onTrack.
  ///
  /// In en, this message translates to:
  /// **'On track'**
  String get onTrack;

  /// No description provided for @good.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// No description provided for @upNext.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get upNext;

  /// No description provided for @now.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get now;

  /// No description provided for @doseRecorded.
  ///
  /// In en, this message translates to:
  /// **'Dose recorded. Your doctor has been notified.'**
  String get doseRecorded;

  /// No description provided for @laterToday.
  ///
  /// In en, this message translates to:
  /// **'Later today'**
  String get laterToday;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @allMedicationsTaken.
  ///
  /// In en, this message translates to:
  /// **'All medications taken for today!'**
  String get allMedicationsTaken;

  /// No description provided for @connectWithDoctors.
  ///
  /// In en, this message translates to:
  /// **'Connect with your doctors'**
  String get connectWithDoctors;

  /// No description provided for @keepMedicalTeamUpdated.
  ///
  /// In en, this message translates to:
  /// **'Keep your medical team updated'**
  String get keepMedicalTeamUpdated;

  /// No description provided for @creatingAccount.
  ///
  /// In en, this message translates to:
  /// **'One moment, we\'re creating your account...'**
  String get creatingAccount;

  /// No description provided for @howShouldWeCallYou.
  ///
  /// In en, this message translates to:
  /// **'How should we call you?'**
  String get howShouldWeCallYou;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Alice Smith'**
  String get fullNameHint;

  /// No description provided for @registrationGreeting.
  ///
  /// In en, this message translates to:
  /// **'Okay {name}!\nWhich email address should we use to create your account?'**
  String registrationGreeting(String name);

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. alice.smith@example.com'**
  String get emailHint;

  /// No description provided for @passwordTitle.
  ///
  /// In en, this message translates to:
  /// **'Now, set up your password.'**
  String get passwordTitle;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Min. 8 characters'**
  String get passwordHint;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get alreadyHaveAccount;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Please select your role to continue setting up your profile'**
  String get selectRole;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @patient.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get patient;

  /// No description provided for @enterDoctorId.
  ///
  /// In en, this message translates to:
  /// **'Enter doctor ID'**
  String get enterDoctorId;

  /// No description provided for @doctorId.
  ///
  /// In en, this message translates to:
  /// **'Doctor ID'**
  String get doctorId;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @linkWithDoctor.
  ///
  /// In en, this message translates to:
  /// **'Link with your doctor'**
  String get linkWithDoctor;

  /// No description provided for @linkWithDoctorDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect with your doctor to securely receive prescriptions, personalized care plans, and direct communication with your healthcare provider.'**
  String get linkWithDoctorDescription;

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code'**
  String get scanQrCode;

  /// No description provided for @proceedManually.
  ///
  /// In en, this message translates to:
  /// **'Proceed manually'**
  String get proceedManually;

  /// No description provided for @doctorFound.
  ///
  /// In en, this message translates to:
  /// **'Doctor found!'**
  String get doctorFound;

  /// No description provided for @confirmAndLink.
  ///
  /// In en, this message translates to:
  /// **'Confirm and link'**
  String get confirmAndLink;

  /// No description provided for @rescanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Rescan QR code'**
  String get rescanQrCode;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @scheduledTime.
  ///
  /// In en, this message translates to:
  /// **'Scheduled time'**
  String get scheduledTime;

  /// No description provided for @reasonForUse.
  ///
  /// In en, this message translates to:
  /// **'Reason for use'**
  String get reasonForUse;

  /// No description provided for @specialInstructions.
  ///
  /// In en, this message translates to:
  /// **'Special instructions'**
  String get specialInstructions;

  /// No description provided for @takeWithFood.
  ///
  /// In en, this message translates to:
  /// **'Take with food'**
  String get takeWithFood;

  /// No description provided for @drinkFullGlassWater.
  ///
  /// In en, this message translates to:
  /// **'Drink a full glass of water'**
  String get drinkFullGlassWater;

  /// No description provided for @refillsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} refills remaining'**
  String refillsRemaining(String count);

  /// No description provided for @activePlans.
  ///
  /// In en, this message translates to:
  /// **'Active plans'**
  String get activePlans;

  /// No description provided for @medications.
  ///
  /// In en, this message translates to:
  /// **'Medications'**
  String get medications;

  /// No description provided for @prescriptions.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions'**
  String get prescriptions;

  /// No description provided for @pastPrescriptions.
  ///
  /// In en, this message translates to:
  /// **'Past prescriptions'**
  String get pastPrescriptions;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @emailDoctor.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailDoctor;

  /// No description provided for @bookOnDoctolib.
  ///
  /// In en, this message translates to:
  /// **'Book on Doctolib'**
  String get bookOnDoctolib;

  /// No description provided for @prescribedMedications.
  ///
  /// In en, this message translates to:
  /// **'Prescribed medications'**
  String get prescribedMedications;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
