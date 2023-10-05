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
                    margin: EdgeInsets.symmetric(vertical: 10.0),
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
                        PopupMenuItem(
                          child: Text('Editar'),
                          value: 'Editar',
                        ),
                        PopupMenuItem(
                          child: Text('Probabilidades'),
                          value: 'Probabilidad',
                        ),
                        PopupMenuItem(
                          child: Text('Anular'),
                          value: 'Anular',
                        ),
                        //PopupMenuItem(child: Text('Editar')),
                      ],
                      onSelected: (value) {
                        if (value == 'Editar') {
                          // Access the root navigator and perform navigation
                          con.editarEvento(e);
                        }
                      },
                    ),
                  )
                ],
              );
            }).toList(),
          ),
        ))
        /*Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            children: con.eventos.map((e) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: size!.width * 1.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://depor.com/resizer/bp0-3vhUuw12xTWyX7WaOjCDXU4=/580x330/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/YRFBTBFFD5GCFK3TEHAEOUR5UQ.jpg'),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.0, color: ColorsApp.black)),
                  ),
                  PopupMenuButton(
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
                            PopupMenuItem(child: Text('Editar')),
                            PopupMenuItem(child: Text('Probabilidades')),
                            PopupMenuItem(child: Text('Editar')),
                            PopupMenuItem(child: Text('Editar')),
                          ])
                ],
              );
            }).toList(),
          ),
        ))*/
      ],
    );
  }
}
