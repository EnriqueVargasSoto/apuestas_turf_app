import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tafur/src/enviroment/enviroment.dart';
import 'package:tafur/src/pages/admin/events/edit_event_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  EditEventController con = EditEventController();
  Size? size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Map event = ModalRoute.of(context)!.settings.arguments as Map;
      await con.init(context, event);
      setState(() {});
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
            'Editar Evento',
            style:
                TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold),
          ),
          foregroundColor: ColorsApp.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            width: size!.width * 1,
            child: Column(
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    controller: con.name,
                    decoration: InputDecoration(
                      hintText: 'Nombre del evento',
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
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: DropDownTextField(
                    //readOnly: true,
                    controller: con.tipo,
                    textFieldDecoration: InputDecoration(
                      hintText: 'Tipo de Evento',
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
                    dropDownItemCount: con.tipos.length,
                    dropDownList: con.tipos,
                    onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    readOnly: true,
                    controller: con.date,
                    decoration: InputDecoration(
                      hintText: 'Fecha del evento',
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
                    onTap: () async {
                      await DatePicker.showDateTimePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(2023, 1, 1),
                        maxTime: DateTime(2101, 12, 31),
                        onChanged: (date) {
                          print('onChanged: $date');
                        },
                        onConfirm: (date) {
                          con.date.text = date.toString();
                          setState(() {
                            //selectedDate = date;
                          });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.es, // Cambia a tu idioma deseado
                      );
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await con.pickImage();
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    padding: EdgeInsets.symmetric(),
                    width: size!.width * 1,
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                        image: con.imageFile != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(con.imageFile!.path)))
                            : DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${Enviroment.imageURL}${con.event['image']}'))),
                    /*child: con.imageFile == null
                        ? Icon(
                            Icons.upload_rounded,
                            color: ColorsApp.background,
                          )
                        : null,*/
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  child: MaterialButton(
                    onPressed: () async {
                      //con.saveEvent();
                    }, //con.registrarUsuario(),

                    color: ColorsApp.background,
                    height: 45.0,
                    minWidth: size!.width * 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Crear Evento',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: ColorsApp.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                /*SizedBox(
                  height: 10.0,
                ),
                Container(
                  //margin: EdgeInsets.symmetric(horizontal: 15.0),
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    children: [
                      Container(
                        width: 50.0,
                        alignment: Alignment.center,
                        child: Text('N˚'),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text('Probabilidad'),
                        ),
                      ),
                      Container(
                        width: 100.0,
                        alignment: Alignment.center,
                        child: Text('valor'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 500.0,
                  child: ListView(
                    children: listProbabilidades(),
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
