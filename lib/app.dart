import 'package:dari/core/theme/app_theme.dart';
import 'package:dari/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dari/l10n/app_localizations.dart';

class DariApp extends StatefulWidget {
  const DariApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    final _DariAppState? state = context
        .findAncestorStateOfType<_DariAppState>();
    state?.setLocale(locale);
  }

  @override
  State<DariApp> createState() => _DariAppState();
}

class _DariAppState extends State<DariApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) {
      return;
    }
    setState(() => _locale = locale);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)?.appName ?? 'Dari',
      theme: AppTheme.lightTheme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
