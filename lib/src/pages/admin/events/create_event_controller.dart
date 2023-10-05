import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:http/http.dart' as http;
import 'package:tafur/src/enviroment/enviroment.dart';
import 'package:tafur/src/utils/colors.dart';

class CreateEventController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();

  TextEditingController nameProbabilidad = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController valor = TextEditingController();
  TextEditingController apuestaMaxima = TextEditingController();

  List<DropDownValueModel> tipos = const [
    DropDownValueModel(name: 'Futbol', value: 'futbol'),
    DropDownValueModel(name: 'Carrera de Caballos', value: 'carrera')
  ];

  SingleValueDropDownController tipo = SingleValueDropDownController();

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
      'name': nameProbabilidad.text,
      'description': descripcion.text,
      'value': valor.text,
      'max': apuestaMaxima.text,
      'amount': apuestaMaxima.text
    };

    probabilidades.add(auxProbabilidad);
  }

  Future saveEvent() async {
    loading();
    Map<String, String> evento = {
      'name': name.text,
      'type': tipo.dropDownValue!.value,
      'date': date.text,
      'tag': 'Pendiente',
      'status': 'active',
    };

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
    };

    print(evento);

    String url = '${Enviroment.apiURL}events';
    var request = http.MultipartRequest('POST', Uri.parse(url))
      ..fields.addAll(evento)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', imageFile!.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseString = await response.stream.bytesToString();
      print(responseString);
    } else {
      var responseString = await response.stream.bytesToString();
      print(responseString);
    }

    cerrarModal();
    Navigator.pushNamedAndRemoveUntil(context!, '/main', (route) => false);
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
