import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/cart.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class ApuestaController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  TextEditingController monto = TextEditingController();

  int total = 0;
  double multiplicador = 1.0;
  Map<String, dynamic> user = {};

  List<dynamic> transferencias = [];
  double montoDouble = 0.000;

  Future init(BuildContext context) async {
    this.context = context;
    sharedPref = SharedPref();

    await setData();
    await getTranferencias();
  }

  Future setData() async {
    dynamic resp = await sharedPref!.read('user');
    user = jsonDecode(resp);
  }

  Future getTranferencias() async {
    await Service.consulta(
            'transaction-user/${user['user']['id']}', 'get', null)
        .then((value) {
      dynamic resp = jsonDecode(value.body);
      transferencias = resp['data'];
      montoDouble = 0.0;
      for (var i = 0; i < transferencias.length; i++) {
        if (transferencias[i]['type'] == 'Recarga' ||
            transferencias[i]['type'] == 'Ganancia' ||
            transferencias[i]['type'] == 'Reintegro') {
          montoDouble += double.parse(transferencias[i]['amount']);
        } else {
          montoDouble -= double.parse(transferencias[i]['amount']);
        }
      }
      //monto.text = montoDouble.toStringAsFixed(3);

      //print(value.body);
    });
  }

  Future saveBet() async {
    loading();
    if (montoDouble >= double.parse(monto.text)) {
      if (total > 0) {
        Map<String, String> body = {
          'user_id': user['user']['id'].toString(),
          'result': 'pendiente',
          'amount_total_bet': monto.text,
          'quota': multiplicador.toString(),
          'amount_total_result': total.toString()
        };

        await Service.consulta('bets', 'post', body).then((value) async {
          print(value.body);
          dynamic bet = jsonDecode(value.body);

          for (var i = 0; i < CartEvents.bets.length; i++) {
            //print(CartEvents.bets[i]['probability']);
            Map<String, String> detailBody = {
              'bet_id': bet['data']['id'].toString(),
              'event_id': CartEvents.bets[i]['id'].toString(),
              'probability_id':
                  CartEvents.bets[i]['probability']['id'].toString(),
              'amount_bet': '0.0',
              'quota': CartEvents.bets[i]['probability']['value'].toString(),
              'amount_result': '0.0',
              'result': 'pendiente'
            };

            await Service.consulta('bet-event', 'post', detailBody)
                .then((value) async {});
          }

          Map<String, String> bodyApuesta = {
            'user_id': user['user']['id'].toString(),
            'type': 'Apuesta',
            'amount': monto.text
          };

          await Service.consulta('transactions', 'post', bodyApuesta)
              .then((value) {
            print(value.body);
            CartEvents.bets = [];

            cerrarModal();
            Navigator.pushNamedAndRemoveUntil(
                context!, '/main', (route) => false);
          });
        });
      } else {
        cerrarModal();
        showDialog(
            context: context!,
            builder: (context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'El monto de ganacia debe ser mayor a 0!.',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      MaterialButton(
                        //minWidth: size!.width * 1,
                        height: 45.0,
                        color: ColorsApp.background,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:
                                BorderSide(color: ColorsApp.black, width: 1.0)),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'OK',
                          style:
                              TextStyle(color: ColorsApp.white, fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }
    } else {
      cerrarModal();
      showDialog(
          context: context!,
          builder: (context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Saldo insuficiente!.',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      //minWidth: size!.width * 1,
                      height: 45.0,
                      color: ColorsApp.background,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: ColorsApp.black, width: 1.0)),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'OK',
                        style:
                            TextStyle(color: ColorsApp.white, fontSize: 15.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
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
            content: Row(
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Colors.amber[100],
                  size: 18,
                ),
                Text(
                  mensaje,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorsApp.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                )
              ],
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
