import 'package:flutter/material.dart';
import 'package:tccflutter/models/note_table_value.dart';
import 'package:tccflutter/models/user.dart';
import 'package:tccflutter/stores/auth_store.dart';

class MainLayout extends StatefulWidget {
  final String title;
  final Widget body;
  final bool loginRequired;
  final String next;

  const MainLayout({super.key, required this.title, required this.body, this.loginRequired = false, this.next = 'Done'});

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

    if (user == null && widget.loginRequired) {
      await Navigator.of(context).popAndPushNamed('Login');
    }
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFDEE2E3),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
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

