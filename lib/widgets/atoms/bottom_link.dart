import 'package:flutter/material.dart';

class BottomLink extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData icon;

  const BottomLink(this.label, {super.key, this.onTap, this.icon = Icons.remove});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        )
      ),
      onPressed: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        width: MediaQuery.of(context).size.height * 0.11,
        color: Theme.of(context).colorScheme.inversePrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black),
            Text(label, style: const TextStyle(
              color: Colors.black
            ),)
          ]
        ),
      ),
    );
  }
}