import 'package:flutter/material.dart';
import 'package:tccflutter/util/custom_route_observer.dart';

class HistoryNavigation extends StatefulWidget {
  final CustomRouteObserver observer;

  const HistoryNavigation({super.key, required this.observer});

  @override
  State<StatefulWidget> createState() => HistoryNavigationState();
}

class HistoryNavigationState extends State<HistoryNavigation> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildNavigationItems()
    );
  }

  List<Widget> _buildNavigationItems() {
    List<Widget> navItems = [];
    int quantPages = widget.observer.pages.length;

    if (quantPages > 0) {
      int startIndex = quantPages > 3 ? quantPages - 3 : 0;

      for (int i = startIndex; i < quantPages; i++) {
        navItems.add(
          GestureDetector(
            onTap: () => popAndNavigateTo(widget.observer.pages[i]),
            child: Text(widget.observer.pages[i]),
          )
        );
        if (i < quantPages - 1) {
          navItems.add(const Text(' > '));
        }
      }
    } else {
      navItems.add(const Text('No navigation history'));
    }

    return navItems;
  }

  void popAndNavigateTo(String name) {
    Navigator.popUntil(context, (route) => route.settings.name == name);
  }
}