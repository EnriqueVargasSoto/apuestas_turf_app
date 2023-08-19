import 'package:flutter/material.dart';

class HomeController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Future init(BuildContext context) async {
    this.context = context;
  }
}
