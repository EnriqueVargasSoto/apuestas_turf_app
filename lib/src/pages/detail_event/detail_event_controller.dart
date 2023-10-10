import 'package:flutter/material.dart';

class DetailEvenController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController probabilidad = TextEditingController();
  TextEditingController montoApuesta = TextEditingController();

  Map event = {};

  Future init(BuildContext context, Map event) async {
    this.context = context;
    this.event = event;
  }
}
