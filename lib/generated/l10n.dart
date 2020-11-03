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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Multi language switching`
  String get lang_title {
    return Intl.message(
      'Multi language switching',
      name: 'lang_title',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home_tab_title {
    return Intl.message(
      'Home',
      name: 'home_tab_title',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get video_tab_title {
    return Intl.message(
      'Video',
      name: 'video_tab_title',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map_tab_title {
    return Intl.message(
      'Map',
      name: 'map_tab_title',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart_tab_title {
    return Intl.message(
      'Cart',
      name: 'cart_tab_title',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member_tab_title {
    return Intl.message(
      'Member',
      name: 'member_tab_title',
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
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}