import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/admin/events/ganadas_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class GanadasScreen extends StatefulWidget {
  const GanadasScreen({super.key});

  @override
  State<GanadasScreen> createState() => _GanadasScreenState();
}

class _GanadasScreenState extends State<GanadasScreen> {
  GanadasController con = GanadasController();
  Size? size;

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
            'Probabilidades Ganadoras',
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
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(children: listProbabilidades()),
            )),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: MaterialButton(
                //enableFeedback: con.event['tag'] == 'Pendiente' ? false : true,
                onPressed: () async {
                  await con.probGanadoras();
                },
                color: ColorsApp.background,
                height: 45.0,
                minWidth: size!.width * 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Guardar Probabilidades Ganadoras',
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
            Checkbox(
              value: con.probabilidades[i]['isSelected'],
              onChanged: (bool? newValue) {
                setState(() {
                  con.checkSelected(con.probabilidades[i]['id'], newValue!);
                  con.probabilidades[i]['isSelected'] = newValue;
                });
              },
            )
            /*Row(
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
            )*/
          ],
        ),
      );
      opt.add(temp);
    }

    return opt;
  }
}
