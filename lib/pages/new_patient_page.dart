import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tccflutter/exceptions/invalid_format_exception.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/patient.dart';
import 'package:tccflutter/stores/patient_store.dart';
import 'package:tccflutter/widgets/atoms/input_text.dart';
import 'package:tccflutter/widgets/atoms/person_image.dart';

class NewPatientPage extends StatefulWidget {
  const NewPatientPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return NewPatientPageState();
  }
}

class NewPatientPageState extends State<NewPatientPage> {
  DateTime? _birthDateTimeFilter;
  DateTime? _treatmentStartedAtDateTimeFilter;
  File? _selectedFile;

  String? message;
  final minNameLength = 4;
  final maxNameLength = 30;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _birthDateTimeController = TextEditingController();
  final _treatmentStartedAtDateTimeController = TextEditingController();

  final FocusNode _focusNodeName = FocusNode();

  Future<DateTime?> _setBirthFilter(BuildContext context) async {
    _birthDateTimeFilter = await _selectDate(context, _birthDateTimeController);

    return _birthDateTimeFilter;
  }

  Future<DateTime?> _setTreatmentStartedAtFilter(BuildContext context) async {
    _treatmentStartedAtDateTimeFilter = await _selectDate(
      context,
      _treatmentStartedAtDateTimeController,
    );

    return _treatmentStartedAtDateTimeFilter;
  }

  Future<DateTime?> _selectDate(
    BuildContext context,
    TextEditingController controller
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1934),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year.toString().padLeft(4, '0')}";
      });
    }

    return picked;
  }

  String? _nameValidator(String? value) {
    if (message != null && message!.isNotEmpty) {
      return message;
    }

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.auth_name_required;
    }

    if (value.length < minNameLength) {
      return AppLocalizations.of(context)!.auth_name_min_length(minNameLength);
    }

    if (value.length < maxNameLength) {
      return AppLocalizations.of(context)!.auth_name_max_length(maxNameLength);
    }

    return null;
  }

  String? _dateValidator(String? value, int minYear, bool isRequired) {
    if (!isRequired && value == null) {
      return null;
    }

    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.birth_required;
    }

    try {
      final date =_mountDateTimeFromString(value)!;

      final minDate = DateTime(minYear, 1, 1);

      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      if (date.isBefore(minDate)) {
        return AppLocalizations.of(context)!.date_min_value(minYear);
      }

      if (date.isAfter(today)) {
        return AppLocalizations.of(context)!.date_is_past;
      }

      return null;
    } on InvalidFormatException {
      return AppLocalizations.of(context)!.invalid_date_format('(dd/MM/yyyy)');
    } catch (e) {
      return AppLocalizations.of(context)!.invalid_date;
    }
  }

  DateTime? _mountDateTimeFromString(String stringDateTime) {
    if (stringDateTime.isEmpty) return null;

    final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regex.hasMatch(stringDateTime)) {
      throw Error.safeToString(AppLocalizations.of(context)!.invalid_date_format('(dd/MM/yyyy)'));
    }

    final parts = stringDateTime.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    var date =DateTime(year, month, day);

    if (date.day != day || date.month != month || date.year != year) {
      throw Error();
    }

    return date;
  }

  void _onTapImage() {
    if (_selectedFile != null) {
      showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: InteractiveViewer(
                child: ClipRRect(
                  child: Image.file(_selectedFile!),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  void _onEditImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _selectedFile = File(file.path);
      });
    }
  }

  void _redirectToPatient(Patient patient) {
    Navigator.of(context).pushNamed('Patient', arguments: {
      'patient': patient
    });
  }

  Future<void> _create() async {
    var birth = _birthDateTimeFilter ??
      _mountDateTimeFromString(_birthDateTimeController.value.text);

    if (birth == null) {
      throw Error();
    }

    var treatmentStartedAt = _treatmentStartedAtDateTimeFilter ??
      _mountDateTimeFromString(_treatmentStartedAtDateTimeController.value.text);

    var patient = await PatientStore().createPatient(
      name: _nameController.value.text,
      birthDate: birth,
      treatmentStartedAt: treatmentStartedAt,
      image: _selectedFile
    );

    if (Navigator.of(context).mounted) {
      _redirectToPatient(patient);
    }
  }

  @override
  Widget build(BuildContext context) {
    var containerLogoHeight = MediaQuery.of(context).size.height * 0.2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30.0),
            PersonImage(
              selectedImage: _selectedFile,
              size: containerLogoHeight,
              border: Border.all(width: 3, color: Colors.grey[800]!),
              onTapImage: _onTapImage,
              pointionedChild: GestureDetector(
                onTap: _onEditImage,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[900]!, width: 1),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: containerLogoHeight * 0.20,
                    color: Colors.grey[900]!,
                  ),
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 30.0),
                  InputText(
                    AppLocalizations.of(context)!.name,
                    focusNode: _focusNodeName,
                    validator: _nameValidator,
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    onSubmitted: _create,
                  ),
                  const SizedBox(height: 30.0),
                  InputText(
                    AppLocalizations.of(context)!.birth,
                    validator: (value) => _dateValidator(value, 1934, true),
                    controller: _birthDateTimeController,
                    height: 40,
                    onTap: () => _setBirthFilter(context),
                    fontSize: 13.5,
                  ),
                  const SizedBox(height: 30.0),
                  InputText(
                    AppLocalizations.of(context)!.patients_treatment_started_at,
                    validator: (value) => _dateValidator(value, 1960, false),
                    controller: _treatmentStartedAtDateTimeController,
                    height: 40,
                    onTap: () => _setTreatmentStartedAtFilter(context),
                    fontSize: 13.5,
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.inversePrimary
                        ),
                      ),
                      onPressed: _create,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Text(
                          AppLocalizations.of(context)!.create,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}