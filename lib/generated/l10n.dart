// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Select Hub`
  String get selectZoneTitle {
    return Intl.message(
      'Select Hub',
      name: 'selectZoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select a Hub`
  String get selectZoneLabel {
    return Intl.message(
      'Select a Hub',
      name: 'selectZoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Open Shift`
  String get openShiftButton {
    return Intl.message(
      'Open Shift',
      name: 'openShiftButton',
      desc: '',
      args: [],
    );
  }

  /// `Error fetching zones`
  String get errorFetchingZones {
    return Intl.message(
      'Error fetching zones',
      name: 'errorFetchingZones',
      desc: '',
      args: [],
    );
  }

  /// `Tayaar App`
  String get appTitle {
    return Intl.message(
      'Tayaar App',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a value!`
  String get enterName {
    return Intl.message(
      'Please enter a value!',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameLabel {
    return Intl.message(
      'Name',
      name: 'nameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a value!`
  String get enterPassword {
    return Intl.message(
      'Please enter a value!',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message(
      'Password',
      name: 'passwordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message(
      'Login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Address:`
  String get addressLabel {
    return Intl.message(
      'Address:',
      name: 'addressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Client:`
  String get clientLabel {
    return Intl.message(
      'Client:',
      name: 'clientLabel',
      desc: '',
      args: [],
    );
  }

  /// `Branch:`
  String get branchLabel {
    return Intl.message(
      'Branch:',
      name: 'branchLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order ID:`
  String get orderIdLabel {
    return Intl.message(
      'Order ID:',
      name: 'orderIdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date:`
  String get dateLabel {
    return Intl.message(
      'Date:',
      name: 'dateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Zone ID:`
  String get zoneIdLabel {
    return Intl.message(
      'Zone ID:',
      name: 'zoneIdLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time:`
  String get timeLabel {
    return Intl.message(
      'Time:',
      name: 'timeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Address`
  String get unknownAddress {
    return Intl.message(
      'Unknown Address',
      name: 'unknownAddress',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Client`
  String get unknownClient {
    return Intl.message(
      'Unknown Client',
      name: 'unknownClient',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Branch`
  String get unknownBranch {
    return Intl.message(
      'Unknown Branch',
      name: 'unknownBranch',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get acceptButton {
    return Intl.message(
      'Accept',
      name: 'acceptButton',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get rejectButton {
    return Intl.message(
      'Reject',
      name: 'rejectButton',
      desc: '',
      args: [],
    );
  }

  /// `Current Order Details`
  String get currentOrderDetailsTitle {
    return Intl.message(
      'Current Order Details',
      name: 'currentOrderDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finishButton {
    return Intl.message(
      'Finish',
      name: 'finishButton',
      desc: '',
      args: [],
    );
  }

  /// `N/A`
  String get nA {
    return Intl.message(
      'N/A',
      name: 'nA',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get ordersTitle {
    return Intl.message(
      'Orders',
      name: 'ordersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Queue Number: `
  String get queueNumberText {
    return Intl.message(
      'Queue Number: ',
      name: 'queueNumberText',
      desc: '',
      args: [],
    );
  }

  /// `Close Shift`
  String get closeShiftButton {
    return Intl.message(
      'Close Shift',
      name: 'closeShiftButton',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
