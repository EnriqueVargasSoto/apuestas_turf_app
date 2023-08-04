import 'package:flutter/material.dart';

class LoginController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  //inputs
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();

  //textos
  String copyRight = 'Create by Cadmustech';
  String titulo = 'APUESTAS TURF';

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future login() async {}

  Future obtenerSesion() async {}

  void loading() {}

  void cerrarModal() {}

  void modalMensaje(String mensaje) {}
}
