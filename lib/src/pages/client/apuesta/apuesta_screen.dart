import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/client/apuesta/apuesta_controller.dart';
import 'package:tafur/src/utils/cart.dart';
import 'package:tafur/src/utils/colors.dart';

class ApuestaScreen extends StatefulWidget {
  const ApuestaScreen({super.key});

  @override
  State<ApuestaScreen> createState() => _ApuestaScreenState();
}

class _ApuestaScreenState extends State<ApuestaScreen> {
  ApuestaController con = ApuestaController();
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
          foregroundColor: ColorsApp.black,
          backgroundColor: ColorsApp.white,
          title: Text(
            'Detalle de Apuesta',
            style: TextStyle(
                color: ColorsApp.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: listBet(),
              ),
            )),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: MaterialButton(
                minWidth: size!.width * 1,
                height: 45.0,
                color: ColorsApp.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: ColorsApp.black, width: 1.0)),
                onPressed: () => {}, //con.createUser(),
                child: Text(
                  'Crear Apuesta',
                  style: TextStyle(color: ColorsApp.white, fontSize: 15.0),
                ),
              ),
            )
            /*Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.center,
              width: size!.width * 1,
              child: Text(
                'DETALLE DE APUESTAS',
                style: TextStyle(
                    color: ColorsApp.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),*/
            /*Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    width: size!.width * 1.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://depor.com/resizer/bp0-3vhUuw12xTWyX7WaOjCDXU4=/580x330/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/YRFBTBFFD5GCFK3TEHAEOUR5UQ.jpg'),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.0, color: ColorsApp.black)),
                  ),
                ],
              ),
            ))*/
          ],
        ),
      ),
    );
  }

  List<Widget> listBet() {
    List<Widget> opt = [];
    opt.add(SizedBox(height: 20.0));
    for (var i = 0; i < CartEvents.bets.length; i++) {
      final widgetTemp = Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: ColorsApp.background),
            borderRadius: BorderRadius.circular(8.0),
            color: ColorsApp.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${CartEvents.bets[i]['name']} ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Probabilidad: ${CartEvents.bets[i]['probability']['name']}${CartEvents.bets[i]['probability']['description'] != null ? ' - ${CartEvents.bets[i]['probability']['description']}' : ''}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Cuota: ${CartEvents.bets[i]['probability']['value']}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Ganancia: ${CartEvents.bets[i]['ganancia']}',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //con.showEstadisticas(
                        //con.event['probabilities'][i]['records']);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            )
          ],
        ),
      );

      opt.add(widgetTemp);
    }
    opt.add(SizedBox(height: 10.0));
    return opt;
  }
}
