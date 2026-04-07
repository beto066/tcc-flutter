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
  bool isLoading = false;
  String? message;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<List<Patient>> _fetchPatients() async {
    setState(() {
      isLoading = true;
    });

    try {
      var fetchedPatients = await PatientStore().fetchPatients();
      setState(() {
        patients = fetchedPatients;
        isLoading = false;
        message = null;
      });
    } catch (e) {
      message = AppLocalizations.of(context)!.patients_fetch_error;
      setState(() {
        isLoading = false;
      });
    }

    return patients;
  }

  void _redirectToPatient(Patient patient) async {
    await Navigator.of(context).pushNamed('Patient', arguments: {
      'patient': patient
    });

    _fetchPatients();
  }

  void _redirectToNewPatient() async {
    await Navigator.of(context).pushNamed('NewPatient');

    _fetchPatients();
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
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            AppLocalizations.of(context)!.patients_screen_description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: (
                (contextHeight * 0.025 < 16)?
                16:
                contextHeight * 0.025
              ),
            ),
          ),
        ),
        SizedBox(height: contextHeight * (contextHeight > 600? 0.04: 0.06)),
        const HistoryNavigation(),
        if (isLoading) const Center(child: CircularProgressIndicator()),

        if (!isLoading && message != null) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),

        if (!isLoading && message == null) Expanded(
          child: ListView.builder(
            itemCount: patients.length + 1,
            itemBuilder: (context, index) {
              if (index == patients.length) {
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
              var patient = patients[index];

              return CardListItem(
                patient.name ?? '',
                initialHeight: 50,
                textAlign: TextAlign.left,
                leading: FutureBuilder(
                  future: PatientStore().getImage(patient),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return PersonImage(
                        size: 40,
                        selectedImage: snapshot.data
                      );
                    }
                    return const PersonImage(size: 40);
                  }
                ),
                onTap: () {
                  _redirectToPatient(patient);
                },
                trailing:  IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _showSurveyDialog(context, patient);
                  }
                ),
              );
            }
          ),
        ),
        SizedBox(height: contextHeight * (contextHeight > 600? 0.04: 0.06)),
      ]
    );
  }
}