import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/theme/default_theme.dart';
import 'package:tccflutter/util/event_controller.dart';
import 'package:tccflutter/widgets/molecules/register_card_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SettingsState();
  }
}

class SettingsState extends State<SettingsPage> {
  final ValueNotifier<Locale> _localeNotifier = ValueNotifier(const Locale('pt', 'BR'));

  void _changeLanguage(Locale? locale) async {
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
      EventController().locale.value = locale;
    }
  }

  void _registerCard() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return const RegisterCardDialog();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    var contextWidth = MediaQuery.of(context).size.width;
    var contextHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          color: Color(int.parse(DefaultTheme.cyan)),
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: contextWidth - 80,
                  padding: const EdgeInsets.all(20),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
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
                              isExpanded: true,
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
                                  child: Text(
                                    'Português',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Locale('en'),
                                  child: Text(
                                    'English',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: Locale('es'),
                                  child: Text(
                                    'Español',
                                    overflow: TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                              onChanged: _changeLanguage,
                            ),
                          ),
                        ]
                      ),
                      // TableRow(
                      //   children: [
                      //     Text(
                      //       "${localization.configurations_screen_difficulty_level}: ",
                      //       style: const TextStyle(fontSize: 16),
                      //       softWrap: false,
                      //     ),
                      //     Container(),
                      //   ]
                      // )
                      // TableRow(
                      //   children: [
                      //     Text(
                      //       "${localization.configurations_screen_difficulty_level}: ",
                      //       style: const TextStyle(fontSize: 16),
                      //       softWrap: false,
                      //     ),
                      //     Container(),
                      //   ]
                      // )
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).colorScheme.inversePrimary
                    ),
                  ),
                  onPressed: _registerCard,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      localization.configurations_screen_register_cards,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}