import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class EventsController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<dynamic> eventos = [];

  Future init(BuildContext context) async {
    this.context = context;
    loading();
    await getEvents();
    cerrarModal();
  }

  void crearEvento() {
    Navigator.pushNamed(context!, '/create_event');
  }

  void editarEvento(Map evento) {
    print('entro a la funcion');
    print(evento);
    Navigator.pushNamed(context!, '/edit_event', arguments: evento);
  }

  Future getEvents() async {
    await Service.consulta('events', 'get', null).then((value) {
      dynamic resp = jsonDecode(value.body);
      eventos = resp['data'];
      print(eventos);
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
}
