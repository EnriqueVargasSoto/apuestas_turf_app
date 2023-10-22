import 'package:flutter/material.dart';
import 'package:tafur/src/pages/admin/events/create_event_screen.dart';
import 'package:tafur/src/pages/admin/events/edit_event_screen.dart';
import 'package:tafur/src/pages/admin/users/cerate_user_screen.dart';
import 'package:tafur/src/pages/admin/users/edit_user_screen.dart';
import 'package:tafur/src/pages/detail_event/detail_event_screen.dart';
import 'package:tafur/src/pages/login/login_screen.dart';
import 'package:tafur/src/pages/main/main_screen.dart';
import 'package:tafur/src/pages/probabilities/probabilities_screen.dart';
import 'package:tafur/src/pages/statistics/statistics_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apuestas TURF',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/statitics': (context) => const StatisticsScreen(),
        '/create_user': (context) => const CreateUserScreen(),
        '/edit_user': (context) => const EditUserScreen(),
        '/create_event': (context) => const CreateEventScreen(),
        '/edit_event': (context) => const EditEventScreen(),
        '/probabilities': (context) => const ProbabilitiesScreen(),
        '/detail_event': (context) => const DetailEventScreen()
      },
    );
  }
}
