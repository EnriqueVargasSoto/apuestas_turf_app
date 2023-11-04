import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/statistics/statistics_controller.dart';
/* import 'package:tafur/src/pages/statistics/statistics_controller.dart'; */
import 'package:tafur/src/utils/colors.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Size? size;
  StatisticsController con = StatisticsController();

  void nuevaProbabilidad() {
    con.estadistica = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            //insetPadding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: con.estadistica,
                    decoration: InputDecoration(
                      hintText: 'Estadistica',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: ColorsApp.background), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: ColorsApp.background), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: ColorsApp.background,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      MaterialButton(
                        color: ColorsApp.background,
                        onPressed: () async {
                          Navigator.pop(context);
                          await con.saveEstadistica().then((value) async {
                            //Navigator.pop(context);
                            //con.loading();

                            //con.cerrarModal();
                            setState(() {});
                          });
                          /*await con.saveProbabilidad().then((value) {
                            setState(() {});
                          });*/
                        },
                        child: Text(
                          'Guardar',
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void editarProbabilidad(record) {
    con.estadistica.text = record['record'];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            //insetPadding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: con.estadistica,
                    decoration: InputDecoration(
                      hintText: 'Estadistica',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: ColorsApp.background), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: ColorsApp.background), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: ColorsApp.background,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      MaterialButton(
                        color: ColorsApp.background,
                        onPressed: () async {
                          Navigator.pop(context);
                          await con
                              .actualizaEstadistica(record)
                              .then((value) async {
                            //con.loading();
                            //await con.getEstadisticas();
                            //con.cerrarModal();
                            setState(() {});
                          });
                          /*await con.saveProbabilidad().then((value) {
                            setState(() {});
                          });*/
                        },
                        child: Text(
                          'Guardar',
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Map probability = ModalRoute.of(context)!.settings.arguments as Map;
      await con.init(context, probability);
      setState(() {});
    });
    /* con.init(); */
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        title: Text(
          'Estadísticas',
          style: TextStyle(
            color: ColorsApp.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: ColorsApp.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 15.0),
          Text(
            'Estadísticas generales',
            style: TextStyle(
              fontSize: 20.0,
              color: ColorsApp.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: MaterialButton(
              /* enableFeedback: con.event['tag'] == 'Pendiente' ? false : true, */
              onPressed: () async {
                nuevaProbabilidad();
                //con.saveEvent();
                /* con.event['tag'] == 'Pendiente' ? nuevaProbabilidad() : null; */
              }, //con.registrarUsuario(),

              color: ColorsApp.background,
              height: 45.0,
              minWidth: size!.width * 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                'Crear Estadistica',
                style: TextStyle(
                    fontSize: 18.0,
                    color: ColorsApp.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(children: listProbabilidades()),
          ))
        ],
      ),
    );
  }

  List<Widget> listProbabilidades() {
    List<Widget> opt = [];

    for (var i = 0; i < con.estadisticas.length; i++) {
      final temp = Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: ColorsApp.background),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${con.estadisticas[i]['record']}'),
                /*Text('Cuota: ${con.probabilidades[i]['value']}'),
                Text('Msx. apuesta: ${con.probabilidades[i]['max']}'),*/
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      editarProbabilidad(con.estadisticas[i]);
                    },
                    icon: const Icon(Icons.edit, color: Colors.grey)),
                IconButton(
                    onPressed: () async {
                      con.loading();
                      await con
                          .eliminarEstadistica(con.estadisticas[i])
                          .then((value) async {
                        await con.getEstadisticas();
                        con.cerrarModal();
                        setState(() {});
                      });
                      /*await con
                          .inactivarProbaiblidad(con.probabilidades[i])
                          .then((value) {
                        setState(() {});
                      });*/
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ),
      );
      opt.add(temp);
    }

    return opt;
  }

  Widget _buildStatisticTile({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: ColorsApp.background),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
