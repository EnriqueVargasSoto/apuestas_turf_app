import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tafur/src/pages/admin/events/events_screen.dart';
import 'package:tafur/src/pages/admin/profile/profile_screen.dart';
import 'package:tafur/src/pages/admin/users/users_screen.dart';
import 'package:tafur/src/pages/client/apuestas/apuestas_screen.dart';
import 'package:tafur/src/pages/client/home/home_screen.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class MainController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  SharedPref? sharedPref;

  Map<String, dynamic> user = {};

  int currentIndex = 0;

  List<BottomNavigationBarItem> menuAdmin = [
    const BottomNavigationBarItem(icon: Icon(Icons.group), label: 'USUARIOS'),
    const BottomNavigationBarItem(icon: Icon(Icons.event), label: 'EVENTOS'),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PERFIL')
  ];

  List<BottomNavigationBarItem> menuUser = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'INICIO'),
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
    ApuestasScreen(),
    ProfileScreen()
  ];

  List<Widget> pages = [];

  Future init(BuildContext context) async {
    this.context = context;
    sharedPref = SharedPref();
    await setearUser();
    await setearData();
  }

  Future setearUser() async {
    dynamic resp = await sharedPref!.read('user');
    user = jsonDecode(resp);

    print(user['user']['role_id'] != '1');
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
