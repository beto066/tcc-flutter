import 'package:flutter/material.dart';
import 'package:tccflutter/util/custom_route_observer.dart';
import 'package:tccflutter/widgets/layouts/main_layout.dart';

void main() {
  final CustomRouteObserver observer = CustomRouteObserver();

  runApp(MyApp(observer: observer));
}

class MyApp extends StatefulWidget {
  late final CustomRouteObserver observer;

  MyApp({super.key, CustomRouteObserver? observer}) {
    this.observer = observer ?? CustomRouteObserver();
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [widget.observer],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'Home',
      routes: {
        'Home': (_) => MainLayout(title: "HELLO", observer: widget.observer),
        'Done': (_) => MainLayout(title: 'title', next: 'Gone', observer: widget.observer),
        'Gone': (_) => MainLayout(title: 'Gone', next: 'Pone', observer: widget.observer),
        'Pone': (_) => MainLayout(title: 'Gone', next: 'Pone', observer: widget.observer),
      },
    );
  }
}
