import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/pages/detail_patient_page.dart';
import 'package:tccflutter/pages/home_page.dart';
import 'package:tccflutter/pages/login_page.dart';
import 'package:tccflutter/pages/patients_page.dart';
import 'package:tccflutter/util/custom_route_observer.dart';
import 'package:tccflutter/widgets/layouts/main_layout.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  final CustomRouteObserver observer = CustomRouteObserver();
  await dotenv.load();
  runApp(MyApp(observer: observer));
}

class MyApp extends StatefulWidget {
  late final CustomRouteObserver observer;

  MyApp({super.key, CustomRouteObserver? observer}) {
    this.observer = observer ?? CustomRouteObserver();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [widget.observer],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.blue,
        ).copyWith(
          inversePrimary: const Color(0xFF7B9FB2),
        ),
      ),
      initialRoute: 'Home',
      routes: {
        'Login': (_) => const MainLayout(title: 'Login', body: LoginPage()),
        'Home': (_) => const MainLayout(title: 'Início', body: HomePage(), loginRequired: true),
        'Pacientes': (_) => const MainLayout(title: 'Pacientes', body: PatientsPage()),
        'Paciente': (context) {
          var arguments = ModalRoute.of(context)!.settings.arguments as Map<String, Patient>;

          return MainLayout(title: "Detalhes do paciente", body: DetailPatientPage(arguments['patient']!));
        },
        'Done': (_) => MainLayout(title: 'title', next: 'Gone', body: Container()),
        'Gone': (_) => MainLayout(title: 'Gone', next: 'Pone', body: Container()),
        'Pone': (_) => MainLayout(title: 'Gone', next: 'Pone', body: Container()
        ),
      },
    );
  }
}
