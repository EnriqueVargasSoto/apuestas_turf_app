import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/main/main_controller.dart';
import 'package:tafur/src/utils/cart.dart';
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
      child: con.loading == false
          ? Scaffold(
              appBar: AppBar(
                backgroundColor: ColorsApp.white,
                leading: con.loading == false
                    ? con.user['user']['role_id'] != '1'
                        ? IconButton(
                            onPressed: () {
                              if (CartEvents.bets.length > 0) {
                                Navigator.pushNamed(context, '/apuesta');
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'NO TENGO APUESTAS AGREGADAS!.',
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                              SizedBox(
                                                height: 20.0,
                                              ),
                                              MaterialButton(
                                                //minWidth: size!.width * 1,
                                                height: 45.0,
                                                color: ColorsApp.background,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    side: BorderSide(
                                                        color: ColorsApp.black,
                                                        width: 1.0)),
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'OK',
                                                  style: TextStyle(
                                                      color: ColorsApp.white,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              }
                            },
                            icon: CartEvents.bets.length > 0
                                ? Badge(
                                    badgeStyle: BadgeStyle(
                                      badgeColor: ColorsApp.background,
                                    ),
                                    badgeContent: Text(
                                      '${CartEvents.bets.length}',
                                      style: TextStyle(
                                          color: ColorsApp.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: Icon(
                                      Icons.shopping_basket_outlined,
                                      color: ColorsApp.black,
                                    ),
                                  )
                                : Icon(
                                    Icons.shopping_basket_outlined,
                                    color: ColorsApp.black,
                                  ))
                        : Container()
                    : Container(),

                title: Text(
                  'Apuestas Turf',
                  style: TextStyle(
                      color: ColorsApp.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.0),
                ),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Prueba.png',
                      height: 40.0,
                    ),
                    Text(
                      'Apuestas Turf',
                      style: TextStyle(
                          color: ColorsApp.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    )
                  ],
                ),*/
                centerTitle: true,
                //leading: Image.assets('assets/')
                actions: [
                  con.loading == false
                      ? con.user['user']['role_id'] != '1'
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Saldo:',
                                    style: TextStyle(
                                        color: ColorsApp.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '₲${con.montoDouble.toInt()}',
                                    style: TextStyle(
                                        color: ColorsApp.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(
                              width: 50.0,
                            )
                      : Container(),
                  const SizedBox(
                    width: 20.0,
                  ),
                ],
              ),
              body: con.loading == false
                  ? con.pages[con.currentIndex]
                  : CircularProgressIndicator(
                      color: ColorsApp.background,
                    ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                showUnselectedLabels: true,
                unselectedItemColor: ColorsApp.black,
                selectedItemColor: ColorsApp.background,
                currentIndex: con.currentIndex,
                unselectedFontSize: 10.0,
                selectedFontSize: 10.0,
                onTap: (index) {
                  setState(() {
                    con.currentIndex = index;
                  });
                },
                items: con.menuSelected,
              )
              //: Container(),
              )
          : CircularProgressIndicator(
              color: ColorsApp.background,
            ),
    );
  }
}
