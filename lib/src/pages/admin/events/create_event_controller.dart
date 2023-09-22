import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:tafur/src/enviroment/enviroment.dart';

class CreateEventController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();

  TextEditingController nameProbabilidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController apuestaMaxima = TextEditingController();

  List<dynamic> probabilidades = [];

  XFile? imageFile;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    imageFile = pickedFile;
  }

  Future agregarProbabilidad() async {
    Map<String, String> auxProbabilidad = {
      'name': name.text,
      'description': descripcion.text,
      'value': valor.text,
      'max': apuestaMaxima.text,
      'amount': apuestaMaxima.text
    };

    probabilidades.add(auxProbabilidad);
  }

  Future saveEvent() async {
    Map<String, String> evento = {
      'name': name.text,
      'date': date.text,
      'status': 'active',
    };

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
    };

    String url = '${Enviroment.apiURL}events';
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(evento)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile!.path));
  }
}
