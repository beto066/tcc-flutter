import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/services/patient_service.dart';

class PatientStore {
  double? weeklyCountPatients;
  double? countPatients;
  List<Patient>? patients;

  static final PatientStore _instance = PatientStore._internal();

  PatientStore._internal();

  factory PatientStore() {
    return _instance;
  }

  Future<double?> fetchCountPatients() async {
    countPatients = await PatientService().fetchCountPatients(null, null);

    return countPatients;
  }

  Future<double?> fetchWeeklyCountPatients() async {
    var from = DateTime.now().toUtc().subtract(const Duration(days: 7));

    weeklyCountPatients = await PatientService().fetchCountPatients(from, null);

    return weeklyCountPatients;
  }

  Future<List<Patient>> fetchPatients() async {
    patients = await PatientService().fetchPatients();

    return patients!;
  }
}