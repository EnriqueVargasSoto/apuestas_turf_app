import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tafur/src/pages/admin/events/create_event_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  CreateEventController con = CreateEventController();
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

  void nuevaProbabilidad() {
    con.nameProbabilidad = TextEditingController();
    con.descripcion = TextEditingController();
    con.valor = TextEditingController();
    con.apuestaMaxima = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            //insetPadding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*DropDownTextField(
                    controller: con.tipo,
                    dropDownItemCount: con.tipos.length,
                    dropDownList: con.tipos,
                    textFieldDecoration: InputDecoration(
                      hintText: 'Tipo de transferencia',
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
                  ),*/
                  TextField(
                    controller: con.nameProbabilidad,
                    decoration: InputDecoration(
                      hintText: 'Probabilidad',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: con.descripcion,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Descripcion',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: con.valor,
                    decoration: InputDecoration(
                      hintText: 'Valor (0.000)',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: con.apuestaMaxima,
                    decoration: InputDecoration(
                      hintText: 'Apuesta maxima (0.000)',
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
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: ColorsApp.background,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      MaterialButton(
                        color: ColorsApp.background,
                        onPressed: () async {
                          await con.agregarProbabilidad();
                          Navigator.pop(context);

                          setState(() {});
                          //con.loading();

                          //await con.saveTranferencia();
                          //await con.getTranferencias();
                          //con.cerrarModal();
                          //setState(() {});
                        },
                        child: Text(
                          'Guardar',
                          style: TextStyle(color: ColorsApp.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
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
            'Crear Evento',
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
                            : null),
                    child: con.imageFile == null
                        ? Icon(
                            Icons.upload_rounded,
                            color: ColorsApp.background,
                          )
                        : null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
                  child: MaterialButton(
                    onPressed: () async {
                      con.saveEvent();
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

  List<Widget> listProbabilidades() {
    List<Widget> opt = [];
    opt.add(Divider());
    for (var i = 0; i < con.probabilidades.length; i++) {
      final temp = Row(
        children: [
          Container(
            width: 50.0,
            alignment: Alignment.center,
            child: Text('${i + 1}'),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text('${con.probabilidades[i]['name']}'),
            ),
          ),
          Container(
            width: 100.0,
            alignment: Alignment.center,
            child: Text('${con.probabilidades[i]['value']}'),
          ),
        ],
      );
      opt.add(temp);
    }
    return opt;
  }
}
