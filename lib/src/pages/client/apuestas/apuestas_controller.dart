import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class ApuestasController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  Map<String, dynamic> user = {};

  List<dynamic> bets = [];

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
      print(value.body);
      dynamic resp = jsonDecode(value.body);
      bets = resp['data'];
    });
  }
}
