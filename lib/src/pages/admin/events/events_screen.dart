import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/enviroment/enviroment.dart';
import 'package:tafur/src/pages/admin/events/events_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventsController con = EventsController();
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: GestureDetector(
            onTap: () => con.crearEvento(),
            child: Container(
              width: size!.width * 1.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1.0, color: ColorsApp.black)),
              child: Icon(
                Icons.add_circle_outline_sharp,
                size: 90.0,
                color: ColorsApp.background,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: con.eventos.map((e) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    width: size!.width * 1.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                '${Enviroment.imageURL}${e['image']}'),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.0, color: ColorsApp.black)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PopupMenuButton(
                      color: ColorsApp.white,
                      icon: Container(
                        height: 40.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            color: ColorsApp.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 1.0, color: ColorsApp.background)),
                        child: Icon(
                          Icons.more_vert_outlined,
                          color: ColorsApp.background,
                        ),
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text('Probabilidades'),
                          value: 'Probabilidad',
                        ),
                        const PopupMenuItem(
                          child: Text('Probabilidades Ganadoras'),
                          value: 'Ganadas',
                        ),
                        PopupMenuItem(
                          child: const Text('Activar'),
                          value: 'Activar',
                          enabled: e['tag'] == 'Pendiente' ? true : false,
                        ),
                        const PopupMenuItem(
                          child: Text('Posponer'),
                          value: 'Posponer',
                        ),

                        /*const PopupMenuItem(
                          child: Text('Terminar'),
                          value: 'Terminar',
                        ),
                        const PopupMenuItem(
                          child: Text('Anular'),
                          value: 'Anular',
                        ),*/
                        const PopupMenuItem(
                          child: Text('Cancelar'),
                          value: 'Cancelar',
                        ),
                        //PopupMenuItem(child: Text('Editar')),
                      ],
                      onSelected: (value) async {
                        switch (value) {
                          case 'Probabilidad':
                            con.probabilities(e);
                            break;

                          case 'Ganadas':
                            con.ganadas(e);
                            break;

                          case 'Activar':
                            await con.activar(e);
                            break;

                          case 'Posponer':
                            await con.posponer(e);
                            break;

                          /*case 'Terminar':
                            print('Terminar');
                            break;*/

                          /*case 'Anular':
                            await con.anular(e);
                            setState(() {});
                            break;*/

                          case 'Cancelar':
                            await con.cancelar(e);
                            //setState(() {});
                            break;

                          default:
                        }
                      },
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ))
      ],
    );
  }
}
