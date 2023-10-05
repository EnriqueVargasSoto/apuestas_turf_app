import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditEventController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Map event = {};

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

  Future init(BuildContext context, Map event) async {
    this.context = context;
    this.event = event;
    await setData();
    print(event);
  }

  Future setData() async {
    name.text = event['name'];
    date.text = event['date'];
    for (var i = 0; i < tipos.length; i++) {
      if (tipos[i].value == event['type']) {
        tipo = SingleValueDropDownController(data: tipos[i]);
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    imageFile = pickedFile;
  }
}
