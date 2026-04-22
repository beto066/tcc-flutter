import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  final ValueNotifier<Locale> _localeNotifier = ValueNotifier(const Locale('pt', 'BR'));

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Text("${localization.configurations_screen_language}: "),
                DropdownButton<Locale>(
                  value: _localeNotifier.value,
                  items: const [
                    DropdownMenuItem(
                      value: Locale('pt', 'BR'),
                      child: Text('Português'),
                    ),
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: Locale('es'),
                      child: Text('Español'),
                    ),
                  ],
                  onChanged: (locale) async {
                    if (locale != null) {
                      final prefs = await SharedPreferences.getInstance();

                      await prefs.setString(
                        'locale_language',
                        locale.languageCode
                      );

                      if (locale.countryCode != null) {
                        await prefs.setString(
                          'locale_country',
                          locale.countryCode!
                        );
                      }

                      _localeNotifier.value = locale;
                    }
                  },
                )
              ],
            )
          ]
        )
      ),
    );
  }
}