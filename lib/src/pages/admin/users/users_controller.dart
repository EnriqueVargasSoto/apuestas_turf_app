import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class UsersController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  List<dynamic> users = [];

  Future init(BuildContext context) async {
    this.context = context;
    loading();
    await listarUsuarios();
    cerrarModal();
  }

  Future listarUsuarios() async {
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
}
