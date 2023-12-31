import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tafur/src/utils/cart.dart';
import 'package:tafur/src/utils/colors.dart';

class DetailEvenController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController probabilidad = TextEditingController();
  TextEditingController montoApuesta = TextEditingController();

  Map event = {};

  Map eventSelect = {};

  Future init(BuildContext context, Map event) async {
    this.context = context;
    this.event = event;
    int indexExistente =
        CartEvents.bets.indexWhere((map) => map['id'] == event['id']);
    if (indexExistente != -1) {
      eventSelect = CartEvents.bets[indexExistente];
    }
    print(this.event);
  }

  void addBet(probability) {
    eventSelect = event;
    eventSelect['probability'] = probability;
    eventSelect['ganancia'] = 0.00;
    print(eventSelect['probability']);

    int indexExistente =
        CartEvents.bets.indexWhere((map) => map['id'] == event['id']);

    if (indexExistente != -1) {
      // Actualiza el mapa existente con los nuevos datos
      CartEvents.bets[indexExistente] = eventSelect;
      /*Fluttertoast.showToast(
          msg: "Se actualizó su probabilidad de este evento!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black,
          fontSize: 16.0);*/
    } else {
      // Agrega el nuevo mapa a la lista
      CartEvents.bets.add(eventSelect);
    }

    //CartEvents.bets.wh
  }

  void showEstadisticas(List<dynamic> estadisticas) {
    showDialog(
        context: context!,
        builder: (context) {
          return Dialog(
            child: estadisticas.length > 0
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: estadisticas.map((e) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e['record']),
                          ),
                          Divider()
                        ],
                      );
                    }).toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'No hay Estadisticas',
                      textAlign: TextAlign.center,
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
