import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';

class TrainingPreferences {
  static const hintDelaySecondsKey = 'training_hint_delay_seconds';
  static const _defaultProgramKey = 'default_training_program';
  static const _defaultDifficultyKey = 'default_training_difficulty';

  static const defaultHintDelaySeconds = 5;
  static const defaultProgram = Program.matching;
  static const defaultDifficulty = DifficultyLevel.distractPhase;

  static Future<int> getHintDelaySeconds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(hintDelaySecondsKey) ?? defaultHintDelaySeconds;
  }

  static Future<void> setHintDelaySeconds(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(hintDelaySecondsKey, seconds);
  }

  static String _userPreferenceKey(String key, int userId) =>
      '${key}_user_$userId';

  static String _patientPreferenceKey(
    String key,
    int userId,
    int patientId,
  ) =>
      '${key}_user_${userId}_patient_$patientId';

  static Future<Program> getDefaultProgram(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final name =
        prefs.getString(_userPreferenceKey(_defaultProgramKey, userId));
    return Program.values.firstWhere(
      (program) => program.name == name,
      orElse: () => defaultProgram,
    );
  }

  static Future<void> setDefaultProgram(int userId, Program program) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _userPreferenceKey(_defaultProgramKey, userId),
      program.name,
    );
  }

  static Future<Program?> getPatientDefaultProgram(
    int userId,
    int patientId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(
      _patientPreferenceKey(_defaultProgramKey, userId, patientId),
    );
    if (name == null) return null;

    return Program.values.firstWhere(
      (program) => program.name == name,
      orElse: () => defaultProgram,
    );
  }

  static Future<void> setPatientDefaultProgram(
    int userId,
    int patientId,
    Program program,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _patientPreferenceKey(_defaultProgramKey, userId, patientId),
      program.name,
    );
  }

  static Future<DifficultyLevel> getDefaultDifficulty(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final name =
        prefs.getString(_userPreferenceKey(_defaultDifficultyKey, userId));

    return DifficultyLevel.values.firstWhere(
      (level) => level.name == name,
      orElse: () => defaultDifficulty,
    );
  }

  static Future<void> setDefaultDifficulty(
    int userId,
    DifficultyLevel level,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _userPreferenceKey(_defaultDifficultyKey, userId),
      level.name,
    );
  }

  static Future<DifficultyLevel?> getPatientDefaultDifficulty(
    int userId,
    int patientId,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString(
      _patientPreferenceKey(_defaultDifficultyKey, userId, patientId),
    );

    if (name == null) return null;

    return DifficultyLevel.values.firstWhere(
      (level) => level.name == name,
      orElse: () => defaultDifficulty,
    );
  }

  static Future<void> setPatientDefaultDifficulty(
    int userId,
    int patientId,
    DifficultyLevel level,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _patientPreferenceKey(_defaultDifficultyKey, userId, patientId),
      level.name,
    );
  }
}
