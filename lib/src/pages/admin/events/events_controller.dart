import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';

class EventsController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  List<dynamic> eventos = [];

  String newDate = '';

  Future init(BuildContext context) async {
    this.context = context;
    loading();
    await getEvents();
    cerrarModal();
  }

  void crearEvento() {
    Navigator.pushNamed(context!, '/create_event');
  }

  void editarEvento(Map evento) {
    print('entro a la funcion');
    print(evento);
    Navigator.pushNamed(context!, '/edit_event', arguments: evento);
  }

  Future getEvents() async {
    await Service.consulta('events', 'get', null).then((value) {
      print(value.body);
      dynamic resp = jsonDecode(value.body);
      print(resp['data'].length);
      if (resp['data'].length > 0) {
        eventos = resp['data'];
      }

      print(eventos);
    });
  }

  Future activar(event) async {
    loading();

    Map<String, String> bodyPosponer = {
      'type': event['type'],
      'name': event['name'],
      'date': event['date'],
      'tag': 'Activo',
      'status': event['status'],
      '_method': 'PUT',
    };

    await Service.consulta('events/${event['id']}', 'post', bodyPosponer)
        .then((value) {
      print(value.body);

      cerrarModal();
      Navigator.pushNamedAndRemoveUntil(context!, '/main', (route) => false);
    });
  }

  Future anular(event) async {
    loading();

    Map<String, String> bodyPosponer = {
      'type': event['type'],
      'name': event['name'],
      'date': event['date'],
      'tag': 'Anulado',
      'status': event['status'],
      '_method': 'PUT',
    };

    await Service.consulta('events/${event['id']}', 'post', bodyPosponer)
        .then((value) {
      print(value.body);

      cerrarModal();
      Navigator.pushNamedAndRemoveUntil(context!, '/main', (route) => false);
    });
  }

  Future posponer(event) async {
    await DatePicker.showDateTimePicker(
      context!,
      showTitleActions: true,
      minTime: DateTime(2023, 1, 1),
      maxTime: DateTime(2101, 12, 31),
      onChanged: (date) {
        print('onChanged: $date');
      },
      onConfirm: (date) async {
        loading();
        newDate = date.toString();
        print(newDate);

        Map<String, String> bodyPosponer = {
          'type': event['type'],
          'name': event['name'],
          'date': newDate,
          'tag': event['tag'],
          'status': event['status'],
          '_method': 'PUT',
        };

        await Service.consulta('events/${event['id']}', 'post', bodyPosponer)
            .then((value) {
          print(value.body);

          cerrarModal();
        });
        //setState(() {
        //selectedDate = date;
        //});
      },
      currentTime: DateTime.now(),
      locale: LocaleType.es, // Cambia a tu idioma deseado
    );
  }

  void probabilities(event) {
    Navigator.pushNamed(context!, '/probabilities', arguments: event);
  }

  void loading() {
    showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: ColorsApp.background,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Cargando...',
                    style: TextStyle(
                      color: ColorsApp.black,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void cerrarModal() {
    Navigator.pop(context!);
  }
}
