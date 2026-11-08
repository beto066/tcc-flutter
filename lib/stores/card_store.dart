import 'package:shared_preferences/shared_preferences.dart';
import 'package:tccflutter/models/app_image.dart';
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
    AppImage image,
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
      _labels = labels;
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
            (label) => label.trim().toLowerCase().contains(
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
        final images = await getImages(label.trim());

        return CardTraining(
          label: label.trim(),
          images: images,
        );
      }),
    );

    return cards;
  }

  Future<AppImage?> getImage(String label, String name) async {
    return await ImageService()
        .getImage('/local-assets/images/cards/$label', name);
  }

  Future<List<AppImage>> getImages(String label) async {
    return await ImageService()
        .getImagesByPath('/local-assets/images/cards/$label');
  }

  Future<void> deleteImage(AppImage image, String label) async {
    await ImageService().deleteImage(image);
    final remainingImages = await getImages(label.trim());

    if (remainingImages.isEmpty) {
      await deleteLabel(label.trim());
    }
  }

  Future<void> deleteLabel(String label) async {
    final prefs = await SharedPreferences.getInstance();
    final labels = prefs.getStringList(prefsKey) ?? [];
    labels.remove(label.trim());

    await prefs.setStringList(prefsKey, labels);

    _labels = labels;

    await ImageService().deleteDirectory('/local-assets/images/cards/$label');
  }

  Future<AppImage> editImage(AppImage oldImage, AppImage newImage) async {
    return ImageService().replaceImage(oldImage, newImage);
  }

  Future<List<String>> get labels async {
    if (_labels != null) return _labels!;

    final prefs = await SharedPreferences.getInstance();
    _labels = prefs.getStringList(prefsKey) ?? [];
    return _labels!;
  }
}
