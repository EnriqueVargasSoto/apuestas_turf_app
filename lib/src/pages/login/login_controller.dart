import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class LoginController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  //inputs
  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();

  //textos
  String copyRight = 'Create by Cadmustech';
  String titulo = 'APUESTAS TURF';

  Map<String, String> body = {};

  Future init(BuildContext context) async {
    this.context = context;
    loading();
    sharedPref = SharedPref();

    cerrarModal();
    await obtenerSesion();
  }

  Future login() async {
    loading();
    body = {'email': usuario.text.trim(), 'password': password.text.trim()};
    try {
      await Service.consulta('login', 'post', body).then((value) {
        dynamic respuesta = jsonDecode(value.body);

        switch (value.statusCode) {
          case 200:
            cerrarModal();
            sharedPref!.save('user', value.body);
            modalMensaje(
                'Bienvenido ${respuesta['user']['names']}', value.statusCode);
            break;

          case 422:
            cerrarModal();
            modalMensaje(
                'Verifique que halla ingresado ambos campos (Usuario y Contraseña).',
                value.statusCode);
            break;

          case 401:
            cerrarModal();
            modalMensaje('Usuario no autorizado.', value.statusCode);
            break;
          default:
        }
      });
    } catch (e) {
      cerrarModal();
      modalMensaje(e.toString(), 500);
    }

    //await Service.consulta('login', 'post', body).then((value) {});
    //Navigator.pushNamedAndRemoveUntil(context!, '/main', (route) => false);
  }

  Future obtenerSesion() async {
    //dynamic rpta = await sharedPref!.read('user');
    //print(rpta);
    if (await sharedPref!.read('user') != null) {
      dynamic rpta = await sharedPref!.read('user');
      print(rpta);
      cerrarModal();
      Navigator.pushNamed(context!, '/main');
    }
  }

  void loading() {
    showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: ColorsApp.background,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Cargando...',
                    style: TextStyle(
                      color: ColorsApp.black,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void cerrarModal() {
    Navigator.pop(context!);
  }

  void modalMensaje(String mensaje, int statusCode) {
    showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              mensaje,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: ColorsApp.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            actions: [
              MaterialButton(
                  onPressed: () {
                    cerrarModal();
                    if (statusCode == 200) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/main', (route) => false);
                    }
                  },
                  color: ColorsApp.background,
                  child: Text(
                    'OK',
                    style: TextStyle(
                        color: ColorsApp.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ))
            ],
            actionsAlignment: MainAxisAlignment.center,
          );
        });
  }
}
