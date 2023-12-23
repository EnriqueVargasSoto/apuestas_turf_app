import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class ApuestasController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  Map<String, dynamic> user = {};

  List<dynamic> bets = [];

  List<dynamic> eventos = [];

  Future init(BuildContext context) async {
    this.context = context;
    sharedPref = SharedPref();
    await setData();
    await getBets();
  }

  Future setData() async {
    dynamic resp = await sharedPref!.read('user');
    user = jsonDecode(resp);
  }

  Future getBets() async {
    await Service.consulta('bets?user_id=${user['user']['id']}', 'get', null)
        .then((value) {
      dynamic resp = jsonDecode(value.body);

      bets = resp['data'];
    });
  }
}

class CardInfo extends StatelessWidget {
  final String estado;
  final String? mensaje;

  CardInfo({super.key, required this.estado, this.mensaje});

  final Map<String, Map<String, dynamic>> _estados = {
    'ganada': {'color': Colors.green, 'texto': 'GANADA'},
    'perdida': {'color': Colors.red, 'texto': 'PERDIDA'},
    'cancelada': {'color': Colors.amber[600], 'texto': 'CANCELADA'},
    'pendiente': {'color': Colors.blue, 'texto': 'PENDIENTE'},
    'otro_estado': {'color': Colors.grey, 'texto': 'Desconocido'},
  };

  String getMensajePersonalizado() {
    return mensaje ?? 'PENDIENTE';
  }

  @override
  Widget build(BuildContext context) {
    _estados['personalizado'] = {
      'color': Colors.black54,
      'texto': getMensajePersonalizado()
    };
    final estadoConfig = _estados[estado] ?? _estados['otro_estado'];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
      decoration: BoxDecoration(
          color: estadoConfig!['color'],
          borderRadius: BorderRadius.circular(3.0)),
      child: Text(
        estadoConfig['texto'],
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.0),
      ),
    );
  }
}
