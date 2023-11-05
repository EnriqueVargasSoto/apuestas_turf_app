import 'package:flutter/material.dart';

class ApuestaController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController monto = TextEditingController();

  double total = 0.00;

  Future init(BuildContext context) async {
    this.context = context;
  }
}
