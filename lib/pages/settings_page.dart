import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/theme/default_theme.dart';

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
    var contextWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          color: Color(int.parse(DefaultTheme.cyan)),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              children: [
                Row(
                  children: [
                    Text(
                      "${localization.configurations_screen_language}: ",
                      style: const TextStyle(fontSize: 16)
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(
                          color: const Color(0xFFDEE2E3),
                        )
                      ),
                      child: DropdownButton<Locale>(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                        dropdownColor: Colors.white,
                        underline: Container(),
                        icon: const Icon(Icons.arrow_drop_down),
                        value: _localeNotifier.value,
                        hint: Text(
                          localization.configurations_screen_language,
                          style: const TextStyle(color: Colors.black)
                        ),
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
                      ),
                    )
                  ],
                )
              ]
            ),
          )
        ),
      ),
    );
  }
}