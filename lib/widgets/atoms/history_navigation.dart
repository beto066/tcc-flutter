import 'package:flutter/material.dart';
import 'package:tccflutter/l10n/app_localizations.dart';
import 'package:tccflutter/util/custom_route_observer.dart';

class HistoryNavigation extends StatefulWidget {
  final CustomRouteObserver? observer;

  const HistoryNavigation({super.key, this.observer});

  @override
  State<StatefulWidget> createState() => HistoryNavigationState();
}

class HistoryNavigationState extends State<HistoryNavigation> {

  List<Widget> _buildNavigationItems() {
    List<Widget> navItems = [];

    CustomRouteObserver observer = widget.observer ??  CustomRouteObserver();
    final localization = AppLocalizations.of(context)!;

    String routeLabel(String route) => switch (route) {
          'Login' => localization.login,
          'Register' => localization.register,
          'Home' => localization.home,
          'Patients' => localization.patients,
          'Notes' => localization.notes,
          'Configurations' => localization.settings,
          'Patient' => localization.patient_details,
          'NewPatient' => localization.new_patient,
          'NoteTable' => localization.note_table_screen,
          'NotePad' => localization.note_pad_screen,
          'NoteTraining' => localization.note_training_screen,
          _ => route,
        };

    int quantPages = observer.pages.length;

    if (quantPages > 0) {
      int startIndex = quantPages > 3 ? quantPages - 3 : 0;

      for (int i = startIndex; i < quantPages; i++) {
        navItems.add(
            GestureDetector(
              onTap: () => popAndNavigateTo(observer.pages[i]),
              child: Text(routeLabel(observer.pages[i])),
            )
        );
        if (i < quantPages - 1) {
          navItems.add(const SizedBox(width: 7.5));
          navItems.add(const Text(' › '));
          navItems.add(const SizedBox(width: 7.5));
        }
      }
    } else {
      navItems.add(Text(AppLocalizations.of(context)!.navigation_history_empty));
    }

    return navItems;
  }

  void popAndNavigateTo(String name) {
    Navigator.popUntil(context, (route) => route.settings.name == name);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildNavigationItems()
    );
  }
}