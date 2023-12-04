import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class GanadasController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Map event = {};

  List<dynamic> probabilidades = [];

  List<int> seleccionado = [];

  Future init(BuildContext context, Map event) async {
    this.context = context;
    this.event = event;
    loading();
    await getProbabilidades();
    cerrarModal();
  }

  Future getProbabilidades() async {
    probabilidades = [];
    await Service.consulta('probabilities?event_id=${event['id']}', 'get', null)
        .then((value) {
      print(value.body);
      dynamic resp = jsonDecode(value.body);
      List<dynamic> list = resp['data'];
      for (var i = 0; i < list.length; i++) {
        if (list[i]['event_id'].toString() == event['id'].toString() &&
            list[i]['status'].toString() == 'active') {
          probabilidades.add(list[i]);
        }
      }
    });

    probabilidades = probabilidades.map((map) {
      map['isSelected'] = false; // o true, según tu lógica inicial
      return map;
    }).toList();
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

  void checkSelected(int id, bool estado) {
    if (estado == true) {
      seleccionado.add(id);
    } else {
      seleccionado.remove(id);
    }

    print(seleccionado);
  }

  Future probGanadoras() async {
    loading();
    Map<String, String> body = {
      'id': event['id'].toString(),
      'ganadas': jsonEncode(seleccionado)
    };

    await Service.consulta('probabilidades-ganadoras', 'post', body)
        .then((value) async {
      print('el valor es');
      print(value.body);
      Map<String, String> bodyPosponer = {
        'type': event['type'],
        'name': event['name'],
        'date': event['date'],
        'tag': 'Terminado',
        'status': 'inactive',
        '_method': 'PUT',
      };

      await Service.consulta('events/${event['id']}', 'post', bodyPosponer)
          .then((value) {
        print(value.body);

        cerrarModal();
        modalMensaje('Probabilidad guardada con éxito', 200);
        //Navigator.pushNamedAndRemoveUntil(context!, '/main', (route) => false);
      });
    });
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
                    //if (statusCode == 200) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                    //}
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
