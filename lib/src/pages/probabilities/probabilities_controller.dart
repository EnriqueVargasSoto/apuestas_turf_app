import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class ProbabilitiesController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController nameProbabilidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController apuestaMaxima = TextEditingController();

  Map event = {};

  List<dynamic> probabilidades = [];

  Future init(BuildContext context, Map event) async {
    this.event = event;
    this.context = context;
    loading();
    await getProbabilidades();
    cerrarModal();
  }

  Future saveProbabilidad() async {
    loading();
    Map<String, String> bodyProbabilidad = {
      'name': nameProbabilidad.text,
      'description': descripcion.text,
      'value': valor.text,
      'max': apuestaMaxima.text,
      'max_aux': apuestaMaxima.text,
      'event_id': event['id'].toString()
    };

    await Service.consulta('probabilities', 'post', bodyProbabilidad)
        .then((value) async {
      print(value.body);
      await getProbabilidades();
      cerrarModal();
    });
  }

  Future getProbabilidades() async {
    probabilidades = [];
    await Service.consulta('probabilities', 'get', null).then((value) {
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
  }

  Future inactivarProbaiblidad(probability) async {
    loading();
    await Service.consulta(
            'inactivar-probabilidad/${probability['id']}', 'get', null)
        .then((value) async {
      print(value.body);
      await getProbabilidades();
      cerrarModal();
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
