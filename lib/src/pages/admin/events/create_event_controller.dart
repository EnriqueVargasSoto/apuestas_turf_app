import 'package:flutter/material.dart';

class CreateEventController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();

  Future init(BuildContext context) async {
    this.context = context;
  }
}
