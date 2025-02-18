import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tccflutter/exceptions/unauthorized_exception.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/stores/note_store.dart';
import 'package:tccflutter/stores/patient_store.dart';
import 'package:tccflutter/widgets/atoms/associative_label.dart';
import 'package:tccflutter/widgets/atoms/button_tile.dart';
import 'package:tccflutter/widgets/molecules/bottom_links.dart';
import 'package:tccflutter/widgets/molecules/chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Map<String, double>? statistics;

  String? statisticsErrorMessage;
  String? patientsErrorMessage;

  void _redirectToPatients() {
    Navigator.of(context).pushNamed('Pacientes');
  }

  Future<Map<String, double>> _fetchStatistics() async {
    try {
      statisticsErrorMessage = null;

      Map<String, double> statistics = {};

      if (NoteStore().statistics == null) {
        statistics = await NoteStore().fetchStatistics();
      } else {
        statistics = NoteStore().statistics ?? {};
      }

      var average = double.tryParse(statistics.remove('average')?.toStringAsFixed(2) ?? '');

      if (average != null) {
        statistics['Média'] = average;
      }

      return statistics;
    } on UnauthorizedException {
      await _logout();
      return {};
    } catch (e) {
      statisticsErrorMessage = e.toString();
      return {};
    }
  }

  Future<double?> _fetchCountPatients() async {
    if (PatientStore().countPatients != null) {
      return PatientStore().countPatients;
    }

    return PatientStore().fetchCountPatients();
  }

  Future<double?> _fetchCountNotes() async {
    if (NoteStore().countNotes != null) {
      return NoteStore().countNotes;
    }

    return NoteStore().fetchCountNotes();
  }

  Future<double?> _fetchWeeklyCountNotes() async {
    if (NoteStore().countWeeklyNotes != null) {
      return NoteStore().countWeeklyNotes;
    }

    return NoteStore().fetchCountWeeklyNotes();
  }

  Future<void> _logout() async {
    await AuthStore().logout();

    await Navigator.of(context).popAndPushNamed('Login');
  }

  @override
  Widget build(BuildContext context) {
    var inversePrimary = Theme.of(context).colorScheme.inversePrimary;
    var contextHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(height: contextHeight * (contextHeight > 600? 0.06: 0.03)),
        Text('Início', style: TextStyle(fontSize: contextHeight * 0.03)),
        Container(
          margin: EdgeInsets.all(contextHeight * 0.03),
          padding: EdgeInsets.symmetric(
            vertical: contextHeight * 0.03,
            horizontal: 10
          ),
          height: contextHeight * 0.28,
          decoration: BoxDecoration(
            border: Border.all(
              width: 4,
              color: inversePrimary,
            ),
            borderRadius: BorderRadius.circular(20)
          ),
          child: FutureBuilder(
            future: _fetchStatistics(),
            builder: (context, snapshot) {
              if (snapshot.hasData && statisticsErrorMessage == null) {
                return Chart(inversePrimary: inversePrimary, statistics: snapshot.data!);

              } else if (snapshot.hasError || statisticsErrorMessage != null) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${statisticsErrorMessage ?? snapshot.error}'),
                );
              }

              return const SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              );
            }
          ),
        ),

        SizedBox(height: contextHeight * 0.02),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
              future: _fetchWeeklyCountNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AssociativeLabel(label: 'Anotações na semana', data: '${snapshot.data!.toInt()}');

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const AssociativeLabel(label: 'Anotações na semana', data: '?');
            }
          ),
        ),

        SizedBox(height: contextHeight * (contextHeight > 600? 0.02: 0.01)),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: _fetchCountPatients(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AssociativeLabel(label: 'Pacientes', data: '${snapshot.data!.toInt()}');

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const AssociativeLabel(label: 'Pacientes', data: '?');
            }
          ),
        ),

        SizedBox(height: contextHeight * (contextHeight > 600? 0.02: 0.01)),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: _fetchCountNotes(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return AssociativeLabel(label: 'Quantidade de anotações', data: '${snapshot.data!.toInt()}');

              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const AssociativeLabel(label: 'Quantidade de anotações', data: '?');
            }
          ),
        ),
        SizedBox(height: contextHeight * (contextHeight > 600? 0.04: 0.02)),

        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: ButtonTile('Paciente(s)', padding: contextHeight * 0.01, onTap: _redirectToPatients),
        ),

        SizedBox(height: contextHeight * (contextHeight > 600? 0.04: 0.02)),
        BottomLinks(logout: _logout),
      ],
    );
  }
}