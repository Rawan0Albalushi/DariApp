import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Dari'**
  String get appName;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @investment.
  ///
  /// In en, this message translates to:
  /// **'Investment'**
  String get investment;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @interactiveDariMap.
  ///
  /// In en, this message translates to:
  /// **'Interactive Dari Map'**
  String get interactiveDariMap;

  /// No description provided for @scanBuilding.
  ///
  /// In en, this message translates to:
  /// **'Scan Building'**
  String get scanBuilding;

  /// No description provided for @featuredProperties.
  ///
  /// In en, this message translates to:
  /// **'Featured Properties'**
  String get featuredProperties;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by area, district, or property type'**
  String get searchHint;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @propertyType.
  ///
  /// In en, this message translates to:
  /// **'Property Type'**
  String get propertyType;

  /// No description provided for @offerType.
  ///
  /// In en, this message translates to:
  /// **'Offer Type'**
  String get offerType;

  /// No description provided for @featuredPropertiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Featured Properties'**
  String get featuredPropertiesTitle;

  /// No description provided for @forSale.
  ///
  /// In en, this message translates to:
  /// **'For Sale'**
  String get forSale;

  /// No description provided for @forRent.
  ///
  /// In en, this message translates to:
  /// **'For Rent'**
  String get forRent;

  /// No description provided for @propertyNameLuxuryApartment.
  ///
  /// In en, this message translates to:
  /// **'Luxury Apartment'**
  String get propertyNameLuxuryApartment;

  /// No description provided for @propertyNameModernVilla.
  ///
  /// In en, this message translates to:
  /// **'Modern Villa'**
  String get propertyNameModernVilla;

  /// No description provided for @propertyNameFamilyHouse.
  ///
  /// In en, this message translates to:
  /// **'Family House'**
  String get propertyNameFamilyHouse;

  /// No description provided for @beds.
  ///
  /// In en, this message translates to:
  /// **'Beds'**
  String get beds;

  /// No description provided for @baths.
  ///
  /// In en, this message translates to:
  /// **'Baths'**
  String get baths;

  /// No description provided for @bottomHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottomHome;

  /// No description provided for @bottomOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get bottomOrders;

  /// No description provided for @bottomMap.
  ///
  /// In en, this message translates to:
  /// **'My Map'**
  String get bottomMap;

  /// No description provided for @bottomFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get bottomFavorites;

  /// No description provided for @bottomAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get bottomAccount;

  /// No description provided for @interactiveMapTitle.
  ///
  /// In en, this message translates to:
  /// **'Interactive Dari Map'**
  String get interactiveMapTitle;

  /// No description provided for @accountOverview.
  ///
  /// In en, this message translates to:
  /// **'Account Overview'**
  String get accountOverview;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @accountUserName.
  ///
  /// In en, this message translates to:
  /// **'Mahmoud Al-Durai'**
  String get accountUserName;

  /// No description provided for @accountUserEmail.
  ///
  /// In en, this message translates to:
  /// **'Mahmoud'**
  String get accountUserEmail;

  /// No description provided for @accountVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified Account'**
  String get accountVerified;

  /// No description provided for @accountEditProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get accountEditProfile;

  /// No description provided for @accountSavedProperties.
  ///
  /// In en, this message translates to:
  /// **'Saved Properties'**
  String get accountSavedProperties;

  /// No description provided for @accountActiveRequests.
  ///
  /// In en, this message translates to:
  /// **'Active Requests'**
  String get accountActiveRequests;

  /// No description provided for @accountAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get accountAppointments;

  /// No description provided for @accountPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get accountPersonalInformation;

  /// No description provided for @accountNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get accountNotifications;

  /// No description provided for @accountLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get accountLanguage;

  /// No description provided for @accountPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get accountPaymentMethods;

  /// No description provided for @accountHelpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get accountHelpSupport;

  /// No description provided for @accountLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get accountLogout;

  /// No description provided for @accountNameFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get accountNameFieldLabel;

  /// No description provided for @accountEmailFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get accountEmailFieldLabel;

  /// No description provided for @accountCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get accountCancel;

  /// No description provided for @accountSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get accountSave;

  /// No description provided for @accountProfileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get accountProfileUpdated;

  /// No description provided for @accountLanguageArabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get accountLanguageArabic;

  /// No description provided for @accountLanguageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get accountLanguageEnglish;

  /// No description provided for @accountLanguageChanged.
  ///
  /// In en, this message translates to:
  /// **'Language selected'**
  String get accountLanguageChanged;

  /// No description provided for @accountLogoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get accountLogoutConfirmMessage;

  /// No description provided for @accountLogoutDone.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully'**
  String get accountLogoutDone;

  /// No description provided for @accountNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled'**
  String get accountNotificationsEnabled;

  /// No description provided for @accountNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications disabled'**
  String get accountNotificationsDisabled;

  /// No description provided for @accountBiometricLogin.
  ///
  /// In en, this message translates to:
  /// **'Biometric Login'**
  String get accountBiometricLogin;

  /// No description provided for @accountBiometricEnabled.
  ///
  /// In en, this message translates to:
  /// **'Biometric login enabled'**
  String get accountBiometricEnabled;

  /// No description provided for @accountBiometricDisabled.
  ///
  /// In en, this message translates to:
  /// **'Biometric login disabled'**
  String get accountBiometricDisabled;

  /// No description provided for @accountSavedPropertiesOpened.
  ///
  /// In en, this message translates to:
  /// **'Saved properties opened'**
  String get accountSavedPropertiesOpened;

  /// No description provided for @accountAppointmentsOpened.
  ///
  /// In en, this message translates to:
  /// **'Appointments opened'**
  String get accountAppointmentsOpened;

  /// No description provided for @accountSupportOpened.
  ///
  /// In en, this message translates to:
  /// **'Support center opened'**
  String get accountSupportOpened;

  /// No description provided for @accountPaymentOpened.
  ///
  /// In en, this message translates to:
  /// **'Payment methods opened'**
  String get accountPaymentOpened;

  /// No description provided for @accountMoreOpened.
  ///
  /// In en, this message translates to:
  /// **'More options opened'**
  String get accountMoreOpened;

  /// No description provided for @propertyDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Property Details'**
  String get propertyDetailsTitle;

  /// No description provided for @priceStartingFrom.
  ///
  /// In en, this message translates to:
  /// **'Starting from'**
  String get priceStartingFrom;

  /// No description provided for @contactAgent.
  ///
  /// In en, this message translates to:
  /// **'Contact Agent'**
  String get contactAgent;

  /// No description provided for @propertyOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get propertyOverviewTitle;

  /// No description provided for @propertyOverviewText.
  ///
  /// In en, this message translates to:
  /// **'A premium unit in a strategic location, designed for daily comfort with practical interior distribution and close access to essential services.'**
  String get propertyOverviewText;

  /// No description provided for @featuresLabel.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get featuresLabel;

  /// No description provided for @amenityPool.
  ///
  /// In en, this message translates to:
  /// **'Swimming Pool'**
  String get amenityPool;

  /// No description provided for @amenityParking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get amenityParking;

  /// No description provided for @amenityGym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get amenityGym;

  /// No description provided for @amenitySecurity.
  ///
  /// In en, this message translates to:
  /// **'24/7 Security'**
  String get amenitySecurity;

  /// No description provided for @bookVisit.
  ///
  /// In en, this message translates to:
  /// **'Book a Visit'**
  String get bookVisit;

  /// No description provided for @propertyAreaValue.
  ///
  /// In en, this message translates to:
  /// **'145 m²'**
  String get propertyAreaValue;

  /// No description provided for @allPropertiesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'All properties'**
  String get allPropertiesPageTitle;

  /// No description provided for @viewAllProperties.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAllProperties;

  /// No description provided for @allPropertiesSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or district'**
  String get allPropertiesSearchHint;

  /// No description provided for @filterAllProperties.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAllProperties;

  /// No description provided for @districtAlMouj.
  ///
  /// In en, this message translates to:
  /// **'Al Mouj, Muscat'**
  String get districtAlMouj;

  /// No description provided for @districtAlKhuwair.
  ///
  /// In en, this message translates to:
  /// **'Al Khuwair, Muscat'**
  String get districtAlKhuwair;

  /// No description provided for @districtQurum.
  ///
  /// In en, this message translates to:
  /// **'Qurum, Muscat'**
  String get districtQurum;

  /// No description provided for @districtBausher.
  ///
  /// In en, this message translates to:
  /// **'Bausher, Muscat'**
  String get districtBausher;

  /// No description provided for @allPropertiesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No properties match your filters or search.'**
  String get allPropertiesEmpty;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
