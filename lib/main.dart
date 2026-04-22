import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/pages/detail_patient_page.dart';
import 'package:tccflutter/pages/home_page.dart';
import 'package:tccflutter/pages/login_page.dart';
import 'package:tccflutter/pages/new_patient_page.dart';
import 'package:tccflutter/pages/note_pad_page.dart';
import 'package:tccflutter/pages/note_table_page.dart';
import 'package:tccflutter/pages/note_training_page.dart';
import 'package:tccflutter/pages/notes_page.dart';
import 'package:tccflutter/pages/patients_page.dart';
import 'package:tccflutter/pages/register_page.dart';
import 'package:tccflutter/pages/settings_page.dart';
import 'package:tccflutter/util/custom_route_observer.dart';
import 'package:tccflutter/widgets/layouts/main_layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tccflutter/l10n/app_localizations.dart';

void main() async {
  final CustomRouteObserver observer = CustomRouteObserver();
  final prefs = await SharedPreferences.getInstance();
  final code = prefs.getString('locale_language');
  final country = prefs.getString('locale_country');
  Locale? locale;

  if (code != null) {
    locale = Locale(code, country);
  }

  await dotenv.load();
  runApp(MyApp(observer: observer, initialLocale: locale));
}

class MyApp extends StatefulWidget {
  late final CustomRouteObserver observer;
  late final Locale? initialLocale;

  MyApp({super.key, this.initialLocale, CustomRouteObserver? observer}) {
    this.observer = observer ?? CustomRouteObserver();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: widget.initialLocale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt', 'BR')
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale == null) {
          return const Locale('en');
        }

        for (final locale in supportedLocales) {
          if (
            locale.languageCode == deviceLocale.languageCode &&
            (locale.countryCode == null ||
            locale.countryCode == deviceLocale.countryCode
          )) {
            return locale;
          }
        }

        return const Locale('en');
      },
      navigatorObservers: [widget.observer],
      title: 'AppLocalizations.of(context)!.aba',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        ).copyWith(
          inversePrimary: const Color(0xFF7B9FB2),
        ),
      ),
      initialRoute: 'Home',
      routes: {
        'Login': (_) => const MainLayout(
          screen: 'login',
          body: LoginPage()
        ),
        'Register': (_) => const MainLayout(
          screen: 'register',
          body: RegisterPage()
        ),
        'Home': (_) => const MainLayout(
          screen: 'home',
          body: HomePage(),
          loginRequired: true
        ),
        'Patients': (_) => const MainLayout(
          screen: 'patients',
          body: PatientsPage()
        ),
        'Notes': (_) => const MainLayout(
          screen: 'notes',
          body: NotesPage()
        ),
        'Configurations': (_) => const MainLayout(
          screen: 'configurations',
          body: SettingsPage()
        ),
        'Patient': (context) {
          var arguments = ModalRoute
            .of(context)!
            .settings
            .arguments as Map<String, Patient>;

          return MainLayout(
            screen: 'patient_details',
            body: DetailPatientPage(arguments['patient']!)
          );
        },
        'NewPatient': (_) => const MainLayout(
          screen: 'new_patient',
          body: NewPatientPage()
        ),
        'NoteTable': (context) {
          var arguments = ModalRoute
            .of(context)!
            .settings
            .arguments as Map<String, Patient>;

          return MainLayout(
            screen: 'note_table',
            body: NoteTablePage(patient: arguments['patient']!)
          );
        },
        'NotePad': (context) {
          var arguments = ModalRoute
              .of(context)!
              .settings
              .arguments as Map<String, Patient>;

          return MainLayout(
              screen: 'note_pad',
              body: NotePadPage(patient: arguments['patient']!)
          );
        },
        'NoteTraining': (context) {
          var arguments = ModalRoute
              .of(context)!
              .settings
              .arguments as Map<String, Patient>;

          return MainLayout(
            screen: 'note_table',
            body: NoteTrainingPage(patient: arguments['patient']!)
          );
        }
      },
    );
  }
}
