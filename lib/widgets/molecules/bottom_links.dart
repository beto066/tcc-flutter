import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/widgets/atoms/bottom_link.dart';

class BottomLinks extends StatelessWidget {
  final VoidCallback? logout;
  final VoidCallback? toConfig;
  final VoidCallback? toNotes;

  const BottomLinks({super.key, this.logout, this.toConfig, this.toNotes});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        BottomLink(
          localization.bottom_link_settings,
          icon: Icons.settings,
          onTap: toConfig,
        ),
        SizedBox(width: MediaQuery.of(context).size.height * 0.03),
        BottomLink(
          localization.bottom_link_notes,
          icon: Icons.sticky_note_2_outlined,
          onTap: toNotes,
        ),
        SizedBox(width: MediaQuery.of(context).size.height * 0.03),
        BottomLink(
          localization.bottom_link_logout,
          icon: Icons.logout,
          onTap: logout,
        ),
      ],
    );
  }
}
