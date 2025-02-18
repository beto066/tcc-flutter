import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/patient_store.dart';
import 'package:tccflutter/widgets/atoms/history_navigation.dart';
import 'package:tccflutter/widgets/atoms/person_image.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/survey_dialog.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PatientsPageState();
  }
}

class _PatientsPageState extends State<PatientsPage> {
  Future<List<Patient>> _fetchPatients() async {
    if (PatientStore().patients == null) {
      await PatientStore().fetchPatients();
    }
    return PatientStore().patients!;
  }

  void _redirectToPatient(Patient patient) {
    Navigator.of(context).pushNamed('Paciente', arguments: {
      'patient': patient
    });
  }

  void _showSurveyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return const SurveyDialog();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var contextHeight = MediaQuery.of(context).size.height;
    return Column(
      children:[
        SizedBox(height: contextHeight * (contextHeight > 600? 0.08: 0.06)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            'Uma explicação simpes sobre a tela',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ((contextHeight * 0.025 < 16)? 16: contextHeight * 0.025),
            ),
          ),
        ),
        SizedBox(height: contextHeight * (contextHeight > 600? 0.04: 0.06)),
        const HistoryNavigation(),
        SizedBox(
          height: contextHeight * 0.5 ,
          child: FutureBuilder(
            future: _fetchPatients(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var patient = snapshot.data![index];

                    return CardListItem(
                      patient.name ?? '',
                      initialHeight: 50,
                      textAlign: TextAlign.left,
                      leading: const PersonImage(size: 40),
                      onTap: () {
                        _redirectToPatient(patient);
                      },
                      trailing:  IconButton(icon: const Icon(Icons.add), onPressed: () {
                        _showSurveyDialog(context);
                      }),
                    );
                  }
                );
              }
              if (snapshot.hasError) {
                return const Text('deu ruim');
              }

              return Container();
            }
          ),
        )
      ]
    );
  }
}