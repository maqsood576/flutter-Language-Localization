import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Switcher App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
          labelLarge: TextStyle(fontSize: 16, color: Colors.white),
        ),
        fontFamily: _locale.languageCode == 'ur'
            ? 'NotoNastaliqUrdu'
            : _locale.languageCode == 'ar'
            ? 'NotoSansArabic'
            : null,
      ),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('ur'),
        Locale('ar'),
      ],
      home: MyHomePage(onLanguageChange: _changeLanguage),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(Locale) onLanguageChange;

  const MyHomePage({super.key, required this.onLanguageChange});

  String _getFormattedDate(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.yMMMEd(locale).format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App Title
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: const Offset(-4, -4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Text(
                    localizations.appTitle,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.teal.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                // Welcome Message
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    localizations.welcome,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // Date Display
                Text(
                  _getFormattedDate(context),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Language Switcher Buttons
                Text(
                  localizations.selectLanguage,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _buildLanguageButton(context, 'English', const Locale('en')),
                    _buildLanguageButton(context, 'हिन्दी', const Locale('hi')),
                    _buildLanguageButton(context, 'اردو', const Locale('ur')),
                    _buildLanguageButton(context, 'العربية', const Locale('ar')),
                  ],
                ),
                const Spacer(),
                // Sample Action Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    backgroundColor: Colors.teal.shade600,
                  ),
                  child: Text(
                    localizations.buttonSave,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageButton(BuildContext context, String label, Locale locale) {
    final isSelected = Localizations.localeOf(context) == locale;
    return GestureDetector(
      onTap: () => onLanguageChange(locale),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade600 : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(3, 3),
              blurRadius: 6,
            ),
            if (!isSelected)
              BoxShadow(
                color: Colors.white,
                offset: const Offset(-3, -3),
                blurRadius: 6,
              ),
          ],
          border: Border.all(
            color: isSelected ? Colors.teal.shade800 : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.teal.shade900,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: locale.languageCode == 'ur'
                ? 'NotoNastaliqUrdu'
                : locale.languageCode == 'ar'
                ? 'NotoSansArabic'
                : null,
          ),
        ),
      ),
    );
  }
}