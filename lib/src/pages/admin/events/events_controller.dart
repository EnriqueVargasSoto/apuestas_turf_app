import 'package:flutter/material.dart';

class EventsController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Future init(BuildContext context) async {
    this.context = context;
  }
}
