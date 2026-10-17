import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/models/card_training.dart';
import 'package:tccflutter/services/image_service.dart';

class CardStore {
  static const prefsKey = 'labels';
  List<String>? _labels;

  static final CardStore _instance = CardStore._internal();

  CardStore._internal();

  factory CardStore() {
    return _instance;
  }

  Future<void> saveImage(
      File image,
      String label,
      String name,
      ) async {
    await ImageService().saveImage(
      image,
      '/local-assets/images/cards/$label',
      name,
    );

    final prefs = await SharedPreferences.getInstance();

    final labels = prefs.getStringList(prefsKey) ?? [];

    if (!labels.contains(label)) {
      labels.add(label);

      await prefs.setStringList(
        prefsKey,
        labels,
      );
    }
  }

  Future<List<CardTraining>> paginateCards({
    int page = 1,
    String? filter,
  }) async {
    const pageSize = 5;

    var labels = await this.labels;

    if (filter != null && filter.isNotEmpty) {
      labels = labels
          .where(
            (label) => label.toLowerCase().contains(
          filter.toLowerCase(),
        ),
      )
          .toList();
    }

    final start = (page - 1) * pageSize;

    if (start >= labels.length) {
      return [];
    }

    final end = (start + pageSize).clamp(0, labels.length);

    final pageLabels = labels.sublist(start, end);

    final cards = await Future.wait(
      pageLabels.map((label) async {
        final images = await getImages(label);

        return CardTraining(
          label: label,
          images: images,
        );
      }),
    );

    return cards;
  }

  Future<File?> getImage(String label, String name) async {
    return await ImageService().getImage('/local-assets/images/cards/$label', name);
  }

  Future<List<File>> getImages(String label) async {
    return await ImageService().getImagesByPath('/local-assets/images/cards/$label');
  }

  Future<List<String>> get labels async {
    if (_labels != null) return _labels!;

    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(prefsKey) ?? [];
  }
}