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
  /// **'Milo'**
  String get appName;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @prescriptions.
  ///
  /// In en, this message translates to:
  /// **'Prescriptions'**
  String get prescriptions;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @dosesLeft.
  ///
  /// In en, this message translates to:
  /// **'You have {count} doses left today.'**
  String dosesLeft(int count);

  /// No description provided for @allDosesTaken.
  ///
  /// In en, this message translates to:
  /// **'You have taken all your medicine for today. Congratulations!'**
  String get allDosesTaken;

  /// No description provided for @taken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get taken;

  /// No description provided for @later.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get later;

  /// No description provided for @expiresInDays.
  ///
  /// In en, this message translates to:
  /// **'Expires in {days} days ({date})'**
  String expiresInDays(int days, String date);

  /// No description provided for @scanMyPrescription.
  ///
  /// In en, this message translates to:
  /// **'Scan my prescription'**
  String get scanMyPrescription;

  /// No description provided for @aiScanDescription.
  ///
  /// In en, this message translates to:
  /// **'Our AI automatically extracts your medications.'**
  String get aiScanDescription;

  /// No description provided for @prescriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Prescription Title'**
  String get prescriptionTitle;

  /// No description provided for @prescriptionEndDate.
  ///
  /// In en, this message translates to:
  /// **'Prescription end date'**
  String get prescriptionEndDate;

  /// No description provided for @medicationName.
  ///
  /// In en, this message translates to:
  /// **'Medication name'**
  String get medicationName;

  /// No description provided for @dosage.
  ///
  /// In en, this message translates to:
  /// **'Dosage'**
  String get dosage;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @timeOptional.
  ///
  /// In en, this message translates to:
  /// **'Time (Optional)'**
  String get timeOptional;

  /// No description provided for @savePrescription.
  ///
  /// In en, this message translates to:
  /// **'Save prescription'**
  String get savePrescription;

  /// No description provided for @onceADay.
  ///
  /// In en, this message translates to:
  /// **'1 time / day'**
  String get onceADay;

  /// No description provided for @twiceADay.
  ///
  /// In en, this message translates to:
  /// **'2 times / day'**
  String get twiceADay;

  /// No description provided for @threeTimesADay.
  ///
  /// In en, this message translates to:
  /// **'3 times / day'**
  String get threeTimesADay;

  /// No description provided for @onceAWeek.
  ///
  /// In en, this message translates to:
  /// **'1 time / week'**
  String get onceAWeek;

  /// No description provided for @asNeeded.
  ///
  /// In en, this message translates to:
  /// **'As needed'**
  String get asNeeded;

  /// No description provided for @takeWithMeal.
  ///
  /// In en, this message translates to:
  /// **'Take during a meal'**
  String get takeWithMeal;

  /// No description provided for @newPrescription.
  ///
  /// In en, this message translates to:
  /// **'New Prescription'**
  String get newPrescription;

  /// No description provided for @editPrescription.
  ///
  /// In en, this message translates to:
  /// **'Edit Prescription'**
  String get editPrescription;

  /// No description provided for @medicationDetails.
  ///
  /// In en, this message translates to:
  /// **'Medication Details'**
  String get medicationDetails;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Instructions'**
  String get instructions;

  /// No description provided for @noMedications.
  ///
  /// In en, this message translates to:
  /// **'No medications scheduled for today.'**
  String get noMedications;
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
