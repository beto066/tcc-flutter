import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/models/enums/difficulty_level.dart';
import 'package:tccflutter/models/enums/program.dart';
import 'package:tccflutter/util/training_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('stores default training program separately for each user', () async {
    await TrainingPreferences.setDefaultProgram(1, Program.receptive);

    expect(
      await TrainingPreferences.getDefaultProgram(1),
      Program.receptive,
    );
    expect(
      await TrainingPreferences.getDefaultProgram(2),
      TrainingPreferences.defaultProgram,
    );
  });

  test('stores default difficulty separately for each user', () async {
    await TrainingPreferences.setDefaultDifficulty(
      1,
      DifficultyLevel.randomRotation,
    );

    expect(
      await TrainingPreferences.getDefaultDifficulty(1),
      DifficultyLevel.randomRotation,
    );
    expect(
      await TrainingPreferences.getDefaultDifficulty(2),
      TrainingPreferences.defaultDifficulty,
    );
  });

  test('stores patient defaults separately and leaves other patients unset',
      () async {
    await TrainingPreferences.setPatientDefaultProgram(
      1,
      10,
      Program.expressive,
    );
    await TrainingPreferences.setPatientDefaultDifficulty(
      1,
      10,
      DifficultyLevel.extendedTraining,
    );

    expect(
      await TrainingPreferences.getPatientDefaultProgram(1, 10),
      Program.expressive,
    );
    expect(
      await TrainingPreferences.getPatientDefaultDifficulty(1, 10),
      DifficultyLevel.extendedTraining,
    );
    expect(
      await TrainingPreferences.getPatientDefaultProgram(1, 11),
      isNull,
    );
    expect(
      await TrainingPreferences.getPatientDefaultDifficulty(1, 11),
      isNull,
    );
    expect(
      await TrainingPreferences.getPatientDefaultProgram(2, 10),
      isNull,
    );
  });
}
