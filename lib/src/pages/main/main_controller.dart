import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/pages/admin/events/events_screen.dart';
import 'package:tafur/src/pages/admin/profile/profile_screen.dart';
import 'package:tafur/src/pages/admin/users/users_screen.dart';
import 'package:tafur/src/pages/client/apuestas/apuestas_screen.dart';
import 'package:tafur/src/pages/client/home/home_screen.dart';
import 'package:tafur/src/pages/client/nosotros/nosotros_screen.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class MainController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  Map<String, dynamic> user = {};

  List<dynamic> transferencias = [];

  double montoDouble = 0.000;

  int currentIndex = 0;

  List<BottomNavigationBarItem> menuAdmin = const [
    BottomNavigationBarItem(icon: Icon(Icons.group), label: 'USUARIOS'),
    BottomNavigationBarItem(icon: Icon(Icons.event), label: 'EVENTOS'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL')
  ];

  List<BottomNavigationBarItem> menuUser = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'NOSOTROS'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.monetization_on), label: 'MIS APUESTAS'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL')
  ];

  List<BottomNavigationBarItem> menuSelected = [];

  List<Widget> pagesAdmin = const [
    UsersScreen(),
    EventsScreen(),
    ProfileScreen()
  ];

  List<Widget> pagesClient = const [
    HomeScreen(),
    NosotrosScreen(),
    ApuestasScreen(),
    ProfileScreen()
  ];

  List<Widget> pages = [];

  bool loading = false;

  Future init(BuildContext context) async {
    this.context = context;
    menuSelected = menuAdmin;
    currentIndex = 0;
    pages = pagesAdmin;
    loading = true;
    sharedPref = SharedPref();
    await setearUser();
    await setearData();
    await getTranferencias();
    loading = false;
  }

  Future setearUser() async {
    dynamic resp = await sharedPref!.read('user');
    user = jsonDecode(resp);

    print(user['user']['role_id'] != '1');
  }

  Future getTranferencias() async {
    await Service.consulta(
            'transaction-user/${user['user']['id']}', 'get', null)
        .then((value) {
      dynamic resp = jsonDecode(value.body);
      transferencias = resp['data'];
      montoDouble = 0.0;
      for (var i = 0; i < transferencias.length; i++) {
        if (transferencias[i]['type'] == 'Recarga') {
          montoDouble += double.parse(transferencias[i]['amount']);
        } else {
          montoDouble -= double.parse(transferencias[i]['amount']);
        }
      }
      //monto.text = montoDouble.toStringAsFixed(3);

      //print(value.body);
    });
  }

  Future setearData() async {
    if (user['user']['role_id'] == '1') {
      currentIndex = 0;
      menuSelected = menuAdmin;
      pages = pagesAdmin;
    } else {
      currentIndex = 0;
      menuSelected = menuUser;
      pages = pagesClient;
    }
  }
}
