import 'package:flutter/material.dart';
import 'package:tccflutter/widgets/atoms/bottom_link.dart';

class BottomLinks extends StatelessWidget {
  final VoidCallback? logout;

  const BottomLinks({super.key, this.logout});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const BottomLink('Config.', icon: Icons.settings),
          SizedBox(width: MediaQuery.of(context).size.height * 0.03),
          const BottomLink('Notas', icon: Icons.sticky_note_2_outlined),
          SizedBox(width: MediaQuery.of(context).size.height * 0.03),
          BottomLink('Sair', icon: Icons.logout, onTap: logout),
        ],
      );
  }
}
