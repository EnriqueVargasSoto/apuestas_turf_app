import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/main/main_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainController con = MainController();
  Size? size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      await con.init(context);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.white,
          leading: Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Image.asset(
              'assets/Prueba.png',
              //height: 80.0,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Apuestas Turf',
                style: TextStyle(
                    color: ColorsApp.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )
            ],
          ),
          centerTitle: true,
          //leading: Image.assets('assets/')
          actions: [
            con.user['user']['role_id'] != '1'
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Saldo:',
                          style: TextStyle(
                              color: ColorsApp.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${con.montoDouble.toStringAsFixed(3)}',
                          style: TextStyle(
                              color: ColorsApp.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    width: 50.0,
                  ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
        body: con.pages[con.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          unselectedItemColor: ColorsApp.black,
          selectedItemColor: ColorsApp.background,
          currentIndex: con.currentIndex,
          onTap: (index) {
            setState(() {
              con.currentIndex = index;
            });
          },
          items: con.menuSelected,
        ),
      ),
    );
  }
}
