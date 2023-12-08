import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/enviroment/enviroment.dart';
import 'package:tafur/src/pages/client/home/home_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController con = HomeController();
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
            'EVENTOS DE LA SEMANA',
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
            children: listEventos(),
          ),
        ))
      ],
    );
  }

  List<Widget> listEventos() {
    List<Widget> opt = [];
    print(con.eventos[0]['date']);
    for (var i = 0; i < con.eventos.length; i++) {
      final temp = GestureDetector(
        onTap: () {
          DateTime horaActual = DateTime.now();
          print(horaActual);
          DateTime horaEvento = DateTime.parse(con.eventos[i]['date']);
          print(horaEvento);
          Duration diferencial = horaEvento.difference(horaActual);
          print(diferencial);

          if (diferencial.inMinutes > 10) {
            print('es mayor a 10 min');
            con.detailEvent(con.eventos[i]);
          } else {
            print('es menor a 10 min');
            con.modalMensaje(
                'El evento esta bloqueado por que esta a punto de empezar o ya empezó!',
                500);
            //con.detailEvent(con.eventos[i]);
          }

          /*final result = Navigator.pushNamed(context, '/detail_event',
              arguments: con.eventos[i]);
          if (result != null) {
            setState(() {});
          }*/
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: size!.width * 1.0,
          height: 150.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      '${Enviroment.imageURL}${con.eventos[i]['image']}'),
                  fit: BoxFit.fitWidth),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1.0, color: ColorsApp.black)),
        ),
      );
      opt.add(temp);
    }

    return opt;
  }
}
