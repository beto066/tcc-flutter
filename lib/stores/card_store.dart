import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/services/image_service.dart';

class CardStore {
  static const prefsKey = 'labels';
  List<String>? _labels;

  static final CardStore _instance = CardStore._internal();

  CardStore._internal();

  factory CardStore() {
    return _instance;
  }

  Future<void> saveImage(File image, String label, String name) async {
    await ImageService().saveImage(image, '/local-assets/images/cards/$label', name);

    final prefs = await SharedPreferences.getInstance();
    var labels = prefs.getStringList(prefsKey) ?? [];

    labels.add(label);

    prefs.setStringList(prefsKey, labels);
  }

  Future<File?> getImage(String label, String name) async {
    return await ImageService().getImage('/local-assets/images/cards/$label', name);
  }

  Future<List<String>> get labels async {
    if (_labels != null) return _labels!;

    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(prefsKey) ?? [];
  }
}