import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/exceptions/localized_app_exception.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/auth_store.dart';

class TrainingHistoryStore {
  static const _keyPrefix = 'training_used_labels_user_';

  Future<String> _storageKey(Patient patient) async {
    final user = await AuthStore().loggedUser;
    final userId = user?.id;
    final patientId = patient.id;
    if (userId == null || patientId == null) {
      throw LocalizedStateError(AppErrorCode.trainingIdentity);
    }

    return '${_keyPrefix}user_${userId}_patient_$patientId';
  }

  Future<Set<String>> getUsedLabels(Patient patient) async {
    final prefs = await SharedPreferences.getInstance();
    final labels = prefs.getStringList(await _storageKey(patient)) ?? [];

    return labels.toSet();
  }

  Future<void> recordUsedLabel(Patient patient, String label) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _storageKey(patient);
    final labels = prefs.getStringList(key) ?? [];

    if (!labels.contains(label)) {
      labels.add(label);
      await prefs.setStringList(key, labels);
    }
  }
}
