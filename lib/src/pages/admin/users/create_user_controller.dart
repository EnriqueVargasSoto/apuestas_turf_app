import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class CreateUserController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController names = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future registrarUsuario() async {
    loading();
    Map<String, String> body = {
      'names': names.text.trim(),
      'email': '${email.text.trim()}@turf.com',
      'password': password.text.trim(),
      'credit': '0.000',
      'status': 'active',
      'role_id': '2'
    };

    await Service.consulta('users', 'post', body).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        cerrarModal();
        modalMensaje(
            'Usuario Registrado de manera correcta.', value.statusCode);
      } else {
        cerrarModal();
        modalMensaje('Error al registrar usuario!.', 500);
      }
    });
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
                      Navigator.pushReplacementNamed(context, '/main');
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
