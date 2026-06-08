import 'package:flutter/material.dart';

class EventController {
  static final EventController _instance = EventController._internal();
  ValueNotifier<Locale?> locale = ValueNotifier(null);

  EventController._internal();

  factory EventController() {
    return _instance;
  }
}