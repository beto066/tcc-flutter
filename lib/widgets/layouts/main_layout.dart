import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/models/user.dart';
import 'package:tccflutter/stores/auth_store.dart';
import 'package:tccflutter/l10n/app_localizations.dart';

class MainLayout extends StatefulWidget {
  final String screen;
  final Widget body;
  final bool loginRequired;
  final String next;

  const MainLayout({super.key, required this.screen, required this.body, this.loginRequired = false, this.next = 'Done'});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  User? user;

  List<NoteTableValue> noteTableValues = [
    NoteTableValue(),
    NoteTableValue(),
    NoteTableValue(),
  ];

  Future<bool?> _verifyLogged() async {
    user = await AuthStore().loggedUser;

    if (user == null && widget.loginRequired && Navigator.of(context).mounted) {
      await Navigator.of(context).popAndPushNamed('Login');
    }
    return user != null;
  }

  String _mapTitle(String screen) {
    switch (screen) {
      case 'login':
        return AppLocalizations.of(context)!.login;
      case 'register':
        return AppLocalizations.of(context)!.register;
      case 'home':
        return AppLocalizations.of(context)!.home;
      case 'patients':
        return AppLocalizations.of(context)!.patients;
      case 'patient_details':
        return AppLocalizations.of(context)!.patient_details;
      case 'note_table':
        return AppLocalizations.of(context)!.note_table_screen;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFDEE2E3),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(_mapTitle(widget.screen)),
        ),
      body: FutureBuilder(
        future: _verifyLogged(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return widget.body;
          } else if (snapshot.hasError) {
            return widget.body;
          }

          return Stack(
            children: [
              const CircularProgressIndicator(),
              Container(color: Colors.white)
            ],
          );
        }
      ),
    );
  }
}

