import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/client/apuestas/apuestas_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class ApuestasScreen extends StatefulWidget {
  const ApuestasScreen({super.key});

  @override
  State<ApuestasScreen> createState() => _ApuestasScreenState();
}

class _ApuestasScreenState extends State<ApuestasScreen> {
  ApuestasController con = ApuestasController();
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          alignment: Alignment.center,
          width: size!.width * 1,
          child: Text(
            'MIS APUESTAS',
            style: TextStyle(
                color: ColorsApp.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: listBets(),
          ),
        ))
      ],
    );
  }

  List<Widget> listBets() {
    List<Widget> opt = [];

    for (var i = 0; i < con.bets.length; i++) {
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${con.bets[i]['code']} ',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Monto Apostado: ${con.bets[i]['amount_total_bet']}',
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Cuota: ${con.bets[i]['quota']}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Monto a Ganar: ${con.bets[i]['amount_total_result']}',
                    maxLines: 2,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Estado: ${con.bets[i]['result']}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            /*SizedBox(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        //con.showEstadisticas(
                        //con.event['probabilities'][i]['records']);
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
                                        'Desea quitar este evento de su apuesta?.',
                                        style: TextStyle(fontSize: 18.0),
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
                                                BorderRadius.circular(10.0),
                                            side: BorderSide(
                                                color: ColorsApp.black,
                                                width: 1.0)),
                                        onPressed: () async {
                                          CartEvents.bets
                                              .remove(CartEvents.bets[i]);
                                          Navigator.pop(context);
                                          if (CartEvents.bets.length == 0) {
                                            Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                '/main',
                                                (route) => false);
                                          }
                                          con.total = 0.00;
                                          con.multiplicador = 1;
                                          //double multiplo = 1.00;
                                          for (var i = 0;
                                              i < CartEvents.bets.length;
                                              i++) {
                                            /*CartEvents.bets[i]['ganancia'] = double.parse(
                                      CartEvents.bets[i]['probability']
                                          ['value']) *
                                  double.parse(con.monto.text);*/
                                            con.multiplicador = double.parse(
                                                    CartEvents.bets[i]
                                                            ['probability']
                                                        ['value']) *
                                                con.multiplicador;
                                            //con.total += CartEvents.bets[i]['ganancia'];
                                          }
                                          con.total =
                                              double.parse(con.monto.text) *
                                                  con.multiplicador;
                                          setState(() {});
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
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            )*/
          ],
        ),
      );

      opt.add(widgetTemp);
    }

    return opt;
  }
}
