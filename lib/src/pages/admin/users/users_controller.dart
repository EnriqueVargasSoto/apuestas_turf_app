import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class UsersController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  List<dynamic> users = [];
  List<dynamic> resultado = [];

  TextEditingController buscador = TextEditingController();

  Future init(BuildContext context) async {
    this.context = context;
    loading();
    await listarUsuarios();
    cerrarModal();
  }

  // Método para realizar la búsqueda.
  void performSearch(value) {
    String query = value.toString().toUpperCase();
    resultado = users.where((element) {
      return element['names'].toString().toUpperCase().contains(query);
    }).toList();
  }

  Future listarUsuarios() async {
    users = [];
    resultado = [];
    await Service.consulta('users', 'get', null).then((value) {
      print(value.body);
      dynamic respuesta = jsonDecode(value.body);
      List<dynamic> listUser = respuesta['data'];
      for (var i = 0; i < listUser.length; i++) {
        if (listUser[i]['role_id'] == '2' &&
            listUser[i]['status'] == 'active') {
          users.add(listUser[i]);
        }
      }
    });
    resultado = users;
  }

  void createUser() {
    Navigator.pushNamed(context!, '/create_user');
  }

  void editUser(Map user) {
    Navigator.pushNamed(context!, '/edit_user', arguments: user);
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

  Future eliminarUsuario(Map<String, dynamic> user) async {
    Map<String, String> body = user.map((key, value) {
      String stringValue = value.toString();
      return MapEntry<String, String>(key, stringValue);
    });
    await Service.consulta('users/${user['id']}', 'delete', null)
        .then((value) => print(value.body));
    //await init(context!);
  }

  void modalMensaje(String mensaje) {
    showDialog(
        //barrierDismissible: false,
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
                    //cerrarModal();
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
