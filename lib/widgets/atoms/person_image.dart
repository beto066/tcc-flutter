import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/models/app_image.dart';
import 'package:tccflutter/widgets/atoms/smart_image.dart';

class PersonImage extends StatelessWidget {
  final String? imageUrl;
  final AppImage? selectedImage;
  final Border? border;
  final Widget? positionedChild;
  final VoidCallback? onTapImage;
  final double size;

  const PersonImage({
    super.key,
    this.imageUrl,
    this.selectedImage,
    this.border,
    this.positionedChild,
    this.onTapImage,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final hasImage =
        selectedImage != null || (imageUrl != null && imageUrl!.isNotEmpty);
    final theme = Theme.of(context);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          MouseRegion(
            cursor: onTapImage != null
                ? SystemMouseCursors.click
                : SystemMouseCursors.basic,
            child: Tooltip(
              message: onTapImage != null
                  ? (hasImage
                      ? localization.image_view_tooltip
                      : localization.image_add_tooltip)
                  : '',
              child: GestureDetector(
                onTap: onTapImage,
                child: ClipOval(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: hasImage ? Colors.white : Colors.grey.shade100,
                      border: border ??
                          Border.all(
                            width: 1,
                            color: hasImage
                                ? Colors.grey.shade300
                                : Colors.blueGrey.shade200,
                          ),
                    ),
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: hasImage
                          ? SmartImage(
                              file: selectedImage,
                              imageUrl: imageUrl,
                              width: size,
                              height: size,
                            )
                          : Icon(
                              Icons.person_rounded,
                              size: size * 0.56,
                              color: Colors.blueGrey.shade600,
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (onTapImage != null && hasImage)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onTapImage,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 0, 0, 0.65),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    size: size * 0.16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          if (onTapImage != null && !hasImage)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.surface,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: size * 0.16,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          if (positionedChild != null)
            Positioned(
              bottom: 0,
              right: 0,
              child: positionedChild!,
            ),
        ],
      ),
    );
  }
}
