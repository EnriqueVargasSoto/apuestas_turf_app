import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/enviroment/enviroment.dart';
import 'package:tafur/src/pages/detail_event/detail_event_controller.dart';
import 'package:tafur/src/utils/cart.dart';
import 'package:tafur/src/utils/colors.dart';

class DetailEventScreen extends StatefulWidget {
  const DetailEventScreen({super.key});

  @override
  State<DetailEventScreen> createState() => _DetailEventScreenState();
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  DetailEvenController con = DetailEvenController();
  Size? size;
  int? selectedProbability;

  void selectProbability(int index) {
    setState(() {
      selectedProbability = index;
    });
  }

  void agregarEvento(probabilidad) {
    con.probabilidad.text = probabilidad['value'];
    con.montoApuesta = TextEditingController();
    probabilidad['montoApuesta'] = con.montoApuesta.text;
    CartEvents.bets.add(probabilidad);
    setState(() {
      selectedProbability = con.event['probabilities'].indexOf(probabilidad);
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Map event = ModalRoute.of(context)!.settings.arguments as Map;
      await con.init(context, event);
      setState(() {
        // Set the selected probability to the first one by default
        selectedProbability;
      });
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
            'Detalle Evento',
            style:
                TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold),
          ),
          foregroundColor: ColorsApp.black,
        ),
        body: Container(
          width: size!.width * 1,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
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
              Row(
                children: [
                  Text(
                    'Tipo : ',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: ColorsApp.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${con.event['type'].toString().toUpperCase()}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: ColorsApp.black,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  Text(
                    'Fecha : ',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: ColorsApp.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${con.event['date'].toString().toUpperCase()}',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: ColorsApp.black,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                width: size!.width * 1.0,
                height: 200.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            '${Enviroment.imageURL}${con.event['image']}'),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1.0, color: ColorsApp.black)),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Probabilidades',
                style: TextStyle(
                    fontSize: 18.0,
                    color: ColorsApp.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Expanded(
                  child: Container(
                child: ListView(
                  children: listProbabilidades(),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> listProbabilidades() {
    List<Widget> opt = [];

    for (var i = 0; i < con.event['probabilities'].length; i++) {
      final temp = GestureDetector(
        onTap: () {
          agregarEvento(con.event['probabilities'][i]);
          selectProbability(i);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          margin: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: ColorsApp.background),
              borderRadius: BorderRadius.circular(8.0),
              color: selectedProbability == i
                  ? ColorsApp.background
                  : ColorsApp.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${con.event['probabilities'][i]['name']} ${con.event['probabilities'][i]['description'] != null ? '- ${con.event['probabilities'][i]['description']}' : ''}'),
                  Text('Cuota: ${con.event['probabilities'][i]['value']}'),
                  Text('Msx. apuesta: ${con.event['probabilities'][i]['max']}'),
                ],
              ),
            ],
          ),
        ),
      );
      opt.add(temp);
    }

    return opt;
  }
}
