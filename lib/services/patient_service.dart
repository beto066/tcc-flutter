import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tccflutter/exceptions/unexpected_exception.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/util/api_service.dart';

class PatientService {
  static final PatientService _instance = PatientService._internal();

  PatientService._internal();

  factory PatientService() {
    return _instance;
  }

  Future<double?> fetchCountPatients(DateTime? from, DateTime? to) async {
    Map<String, String> queryParams = {};

    if (from != null) {
      queryParams['from'] = from.toIso8601String();
    }

    if (to != null) {
      queryParams['to'] = to.toIso8601String();
    }

    var response = await ApiService().get('/patients/count', queryParams: queryParams);

    var decodedBody = double.tryParse(response.body);

    if (decodedBody == null) {
      throw UnexpectedException('O valor retornado não é uma string');
    }

    return decodedBody;
  }

  Future<List<Patient>> fetchPatients() async {
    var response = await ApiService().get('/patients');
    List<dynamic> decoded = jsonDecode(response.body);

    var patients = decoded.map((patient) {
      if (patient is Map<String, dynamic>) {
        return Patient.factory(patient);
      }
      return Patient();
    }).toList();

    return patients;
  }
}