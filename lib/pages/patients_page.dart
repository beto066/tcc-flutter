import 'package:flutter/material.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/patient_store.dart';
import 'package:tccflutter/widgets/atoms/history_navigation.dart';
import 'package:tccflutter/widgets/atoms/person_image.dart';
import 'package:tccflutter/widgets/molecules/card_list_item.dart';
import 'package:tccflutter/widgets/molecules/survey_dialog.dart';
import 'package:tccflutter/l10n/app_localizations.dart';

class PatientsPage extends StatefulWidget {
  const PatientsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PatientsPageState();
  }
}

class _PatientsPageState extends State<PatientsPage> {
  List<Patient> patients = [];

  Future<List<Patient>> _fetchPatients() async {
    if (patients.isEmpty) {
      patients = await PatientStore().fetchPatients();
    }
    return patients;
  }

  void _redirectToPatient(Patient patient) {
    Navigator.of(context).pushNamed('Patient', arguments: {
      'patient': patient
    });
  }

  void _redirectToNewPatient() {
    Navigator.of(context).pushNamed('NewPatient');
  }

  void _showSurveyDialog(BuildContext context, Patient patient) {
    showDialog(
      context: context,
      builder: (context) {
        return SurveyDialog(patient: patient);
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
            AppLocalizations.of(context)!.patients_screen_description,
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
                  itemCount: snapshot.data!.length + 1,
                  itemBuilder: (context, index) {
                    if (index == snapshot.data!.length) {
                      return CardListItem(
                        AppLocalizations.of(context)!.new_patient,
                        initialHeight: 50,
                        textAlign: TextAlign.left,
                        leading: const Icon(Icons.add),
                        onTap: () {
                          _redirectToNewPatient();
                        },
                      );
                    }
                    var patient = snapshot.data![index];

                    return CardListItem(
                      patient.name ?? '',
                      initialHeight: 50,
                      textAlign: TextAlign.left,
                      leading: FutureBuilder(
                        future: PatientStore().getImage(patient),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return PersonImage(size: 40, selectedImage: snapshot.data);
                          }
                          return const PersonImage(size: 40);
                        }
                      ),
                      onTap: () {
                        _redirectToPatient(patient);
                      },
                      trailing:  IconButton(icon: const Icon(Icons.add), onPressed: () {
                        _showSurveyDialog(context, patient);
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