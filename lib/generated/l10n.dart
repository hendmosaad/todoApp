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

  /// ` hello`
  String get title {
    return Intl.message(
      ' hello',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `focus on your productivity `
  String get wortTitle {
    return Intl.message(
      'focus on your productivity ',
      name: 'wortTitle',
      desc: '',
      args: [],
    );
  }

  /// `a sound mind in a sound body`
  String get healthTitle {
    return Intl.message(
      'a sound mind in a sound body',
      name: 'healthTitle',
      desc: '',
      args: [],
    );
  }

  /// `pay attention to your soul`
  String get religiousTitle {
    return Intl.message(
      'pay attention to your soul',
      name: 'religiousTitle',
      desc: '',
      args: [],
    );
  }

  /// `you have rights to yous self`
  String get hopiesTitle {
    return Intl.message(
      'you have rights to yous self',
      name: 'hopiesTitle',
      desc: '',
      args: [],
    );
  }

  /// `journalising can be a therapy `
  String get notesTitle {
    return Intl.message(
      'journalising can be a therapy ',
      name: 'notesTitle',
      desc: '',
      args: [],
    );
  }

  /// `family is evry thing`
  String get familyTitle {
    return Intl.message(
      'family is evry thing',
      name: 'familyTitle',
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
