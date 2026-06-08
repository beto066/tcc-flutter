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
  final _labelController = TextEditingController();
  final _focusNodeLabel = FocusNode();
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

  void _onEditImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _image = File(file.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    var buttonColor = Theme.of(context).colorScheme.inversePrimary;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Container(
        margin: const EdgeInsets.all(24),
        child: Form(
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

              const SizedBox(height: 28),

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
                        width: 140,

                        decoration: BoxDecoration(
                          color: Colors.lightBlue[50],
                          borderRadius: BorderRadius.circular(20),

                          border: Border.all(
                            color: buttonColor,
                            width: 2,
                          ),
                        ),
                        child: SmartImage(
                          file: _image,
                          defaultIcon: Icons.add_photo_alternate,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              InputAutocomplete(
                localization.configurations_screen_select_label,
                focusNode: _focusNodeLabel,
                controller: _labelController,
                options: _labels,
                validator: _validateLabel,
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton.icon(
                  onPressed: () {},

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