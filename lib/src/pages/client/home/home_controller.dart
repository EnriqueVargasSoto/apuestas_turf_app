import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class HomeController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  List<dynamic> eventos = [];

  Future init(BuildContext context) async {
    this.context = context;
    loading();
    await getEventos();
    cerrarModal();
  }

  Future getEventos() async {
    await Service.consulta('eventos-activos', 'get', null).then((value) {
      print(value.body);
      eventos = jsonDecode(value.body);
      print(eventos);
    });
  }

  void detailEvent(event) {
    Navigator.pushNamed(context!, '/detail_event', arguments: event);
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
