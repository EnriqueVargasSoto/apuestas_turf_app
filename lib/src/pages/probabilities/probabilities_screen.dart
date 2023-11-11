import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/probabilities/probabilities_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class ProbabilitiesScreen extends StatefulWidget {
  const ProbabilitiesScreen({super.key});

  @override
  State<ProbabilitiesScreen> createState() => _ProbabilitiesScreenState();
}

class _ProbabilitiesScreenState extends State<ProbabilitiesScreen> {
  ProbabilitiesController con = ProbabilitiesController();
  Size? size;

  void nuevaProbabilidad() {
    con.nameProbabilidad = TextEditingController();
    con.descripcion = TextEditingController();
    con.valor = TextEditingController();
    con.apuestaMaxima = TextEditingController();
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
                    controller: con.nameProbabilidad,
                    decoration: InputDecoration(
                      hintText: 'Probabilidad',
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
                  TextField(
                    controller: con.descripcion,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Descripcion',
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
                  TextField(
                    controller: con.valor,
                    decoration: InputDecoration(
                      hintText: 'Valor (0.000)',
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
                  /*TextField(
                    controller: con.apuestaMaxima,
                    decoration: InputDecoration(
                      hintText: 'Apuesta maxima (0.000)',
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
                  ),*/
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
                          await con.saveProbabilidad().then((value) {
                            setState(() {});
                          });
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

  void editarProbabilidad(probabilidad) {
    con.nameProbabilidad.text = probabilidad['name'];
    con.descripcion.text = probabilidad['description'];
    con.valor.text = probabilidad['value'];
    con.apuestaMaxima.text = probabilidad['max'];
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
                    controller: con.nameProbabilidad,
                    decoration: InputDecoration(
                      hintText: 'Probabilidad',
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
                  TextField(
                    controller: con.descripcion,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Descripcion',
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
                  TextField(
                    controller: con.valor,
                    decoration: InputDecoration(
                      hintText: 'Valor (0.000)',
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
                  /*TextField(
                    controller: con.apuestaMaxima,
                    decoration: InputDecoration(
                      hintText: 'Apuesta maxima (0.000)',
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
                  ),*/
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
                              .updateProbailidad(probabilidad)
                              .then((value) {
                            setState(() {});
                          });
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
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Map event = ModalRoute.of(context)!.settings.arguments as Map;
      await con.init(context, event).then((value) => setState(() {}));
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.white,
          title: Text(
            'Probabilidades',
            style:
                TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold),
          ),
          foregroundColor: ColorsApp.black,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 15.0,
            ),
            Text(
              '${con.event['name']}',
              style: TextStyle(
                  fontSize: 20.0,
                  color: ColorsApp.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: MaterialButton(
                enableFeedback: con.event['tag'] == 'Pendiente' ? false : true,
                onPressed: () async {
                  //con.saveEvent();
                  con.event['tag'] == 'Pendiente' ? nuevaProbabilidad() : null;
                }, //con.registrarUsuario(),

                color: ColorsApp.background,
                height: 45.0,
                minWidth: size!.width * 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Crear Probabilidad',
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
      ),
    );
  }

  List<Widget> listProbabilidades() {
    List<Widget> opt = [];

    for (var i = 0; i < con.probabilidades.length; i++) {
      final temp = Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: ColorsApp.background),
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${con.probabilidades[i]['name']} ${con.probabilidades[i]['description'] != null ? '- ${con.probabilidades[i]['description']}' : ''}',
                    maxLines: 2,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Cuota: ${con.probabilidades[i]['value']}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  //Text('Msx. apuesta: ${con.probabilidades[i]['max']}'),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      con.estadistica(con.probabilidades[i]);
                    },
                    icon: const Icon(Icons.remove_red_eye_outlined,
                        color: Colors.grey)),
                IconButton(
                    onPressed: () async {
                      editarProbabilidad(con.probabilidades[i]);
                    },
                    icon: const Icon(Icons.edit, color: Colors.blue)),
                IconButton(
                    onPressed: () async {
                      await con
                          .inactivarProbaiblidad(con.probabilidades[i])
                          .then((value) {
                        setState(() {});
                      });
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
}
