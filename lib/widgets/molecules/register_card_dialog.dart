import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/stores/card_store.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';
import 'package:tccflutter/widgets/molecules/input_auto_complete.dart';

class RegisterCardDialog extends StatefulWidget {
  const RegisterCardDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterCardDialogState();
  }
}

class _RegisterCardDialogState extends State<RegisterCardDialog> {
  final _formKey = GlobalKey<FormState>();
  final _labelController = TextEditingController();
  final _focusNodeLabel = FocusNode();
  String? _imageErrorMessage;

  File? _image;
  List<String> _labels = [];

  @override
  void initState() {
    _loadLabels();
    super.initState();
  }

  Future<void> _loadLabels() async {
    final loaded = await CardStore().labels;

    setState(() {
      _labels = loaded;
    });
  }

  String? _validateLabel(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.configurations_screen_register_card_label_required;
    }

    return null;
  }

  Future<void> _onEditImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }
  }

  Future<void> _save() async {
    if (_image == null) {
      setState(() {
        _imageErrorMessage = AppLocalizations.of(context)!
          .configurations_screen_image_required;
      });
      return;
    }
    if (_labelController.value.text.isEmpty) return;

    final label = _labelController.value.text;

    CardStore().saveImage(
      _image!,
      label,
      "/${_labels.length}"
    );

    if (!context.mounted) return;

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(
        AppLocalizations.of(context)!.configurations_screen_card_saved)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    var buttonColor = Theme.of(context).colorScheme.inversePrimary;

    var contextHeight = MediaQuery.of(context).size.height;
    var contextWidth = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 36),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Center(
                child: Text(
                  localization.configurations_screen_register_card,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Center(
                child: Column(
                  children: [
                    Text(
                      localization.configurations_screen_register_send_image,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _onEditImage,
                      child: Ink(
                        width: 100,
                        height: 100,

                        padding: const EdgeInsetsGeometry.all(5),

                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                            color: const Color(0xFF7A8CBA),
                            width: 2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: SmartImage(
                            file: _image,
                            defaultIcon: Icons.add_photo_alternate,
                          ),
                        ),
                      ),
                    ),
                    if (
                      _imageErrorMessage != null &&
                      _imageErrorMessage!.isNotEmpty
                    ) Text(
                      _imageErrorMessage!,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height:  12),

              InputAutocomplete(
                localization.configurations_screen_select_label,
                focusNode: _focusNodeLabel,
                controller: _labelController,
                options: _labels,
                fontSize: 10,
                validator: _validateLabel,
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: _save,

                  icon: const Icon(Icons.save, color: Colors.black),

                  label: Text(
                    localization.save,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black
                    ),
                  ),

                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      buttonColor
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}