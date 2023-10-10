import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  TextEditingController names = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Map<String, dynamic> user = {};

  Future init(BuildContext context) async {
    this.context = context;
    sharedPref = SharedPref();
    loading();
    await setearData();
    cerrarModal();
  }

  Future setearData() async {
    dynamic resp = await sharedPref!.read('user');
    user = jsonDecode(resp);
    user['user']['clave'] != null ? password.text = user['user']['clave'] : '';
    names.text = user['user']['names'];
    email.text = user['user']['email']
        .toString()
        .substring(0, user['user']['email'].toString().length - 9);
    print(user['user']);
  }

  Future updateUser() async {}

  Future cerrarSesion() async {
    await sharedPref!.clear();
    Navigator.pushNamedAndRemoveUntil(context!, '/login', (route) => false);
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

  launchWhatsApp(String number) async {
    // Número de teléfono de destino (debe incluir el código de país)
    String phoneNumber =
        number; //"+595985704200"; // Reemplaza con el número de teléfono deseado
    // Mensaje predeterminado (opcional)
    String message = "Hola, deseo hacer un depósito/retiro";

    // URL de WhatsApp
    String url = "https://wa.me/$phoneNumber/?text=${Uri.encodeFull(message)}";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // No se pudo abrir WhatsApp, manejar el caso de error aquí
      print('No se pudo abrir WhatsApp.');
    }
  }

  Future updateImage() async {}

  Future updatePassword() async {
    Map<String, String> bodyPassword = {'password': password.text};

    await Service.consulta(
            'actualiza-password/${user['user']['id']}', 'post', bodyPassword)
        .then((value) async {
      print(value.body);
      await login();
    });
  }

  Future login() async {
    loading();
    Map<String, String> body = {
      'email': '${email.text.trim()}@turf.com',
      'password': password.text.trim()
    };
    try {
      sharedPref!.clear();
      await Service.consulta('login', 'post', body).then((value) {
        dynamic respuesta = jsonDecode(value.body);
        print(respuesta);
        cerrarModal();
        //if (respuesta['user']['status'] == 'active') {
        sharedPref!.save('user', value.body);
      });
    } catch (e) {
      cerrarModal();
      modalMensaje(e.toString(), 500);
    }

    //await Service.consulta('login', 'post', body).then((value) {});
    //Navigator.pushNamedAndRemoveUntil(context!, '/main', (route) => false);
  }
}
