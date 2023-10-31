import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class StatisticsController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController estadistica = TextEditingController();

  List<dynamic> estadisticas = [];

  Map probability = {};

  Future init(BuildContext context, Map probability) async {
    //this.event = event;

    this.context = context;
    this.probability = probability;
    loading();
    await getEstadisticas();
    cerrarModal();
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

  Future getEstadisticas() async {
    await Service.consulta('records/${probability['id']}', 'get', null)
        .then((value) {
      print(value.body);
      estadisticas = jsonDecode(value.body);
    });
  }

  Future saveEstadistica() async {
    Map<String, String> body = {
      'probability_id': '${probability['id']}',
      'record': estadistica.text
    };

    await Service.consulta('records', 'post', body).then((value) {
      print(value.body);
    });
  }

  Future actualizaEstadistica(record) async {
    Map<String, String> body = {
      'probability_id': '${record['probability_id']}',
      'record': estadistica.text
    };

    await Service.consulta('records/${record['id']}', 'put', body)
        .then((value) {
      print(value.body);
    });
  }

  Future eliminarEstadistica(record) async {
    await Service.consulta('records/${record['id']}', 'delete', null)
        .then((value) {
      print(value.body);
    });
  }
}
