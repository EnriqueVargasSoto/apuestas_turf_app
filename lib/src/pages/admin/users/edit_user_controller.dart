import 'dart:convert';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:tafur/src/utils/colors.dart';
import 'package:tafur/src/utils/service.dart';
import 'package:tafur/src/utils/shared_pref.dart';

class EditUserController {
  BuildContext? context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  TextEditingController names = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController monto = TextEditingController();
  TextEditingController montoTransferencia = TextEditingController();
  double montoDouble = 0.00;

  SharedPref? sharedPref;

  Map<String, dynamic> user = {};

  List<dynamic> transferencias = [];

  List<DropDownValueModel> tipos = const [
    DropDownValueModel(name: 'Recarga', value: 'Recarga'),
    DropDownValueModel(name: 'Retiro', value: 'Retiro'),
  ];

  SingleValueDropDownController tipo =
      SingleValueDropDownController(data: null);

  Future init(BuildContext context, Map user) async {
    this.context = context;
    this.user = user as Map<String, dynamic>;
    monto.text = montoDouble.toStringAsFixed(2);
    montoTransferencia.text = '0.00';
    //sharedPref = SharedPref();
    await setearData();
    await getTranferencias();
    loading();
    cerrarModal();
  }

  Future setearData() async {
    print(user);
    names.text = user['names'];
  }

  void nuevaTransaccion() {
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return Dialog(
            //insetPadding: EdgeInsets.symmetric(vertical: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropDownTextField(
                    controller: tipo,
                    dropDownItemCount: tipos.length,
                    dropDownList: tipos,
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
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: montoTransferencia,
                    decoration: InputDecoration(
                      hintText: '0.00',
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
                          await saveTranferencia();
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

  Future getTranferencias() async {
    await Service.consulta('transaction-user/${user['id']}', 'get', null)
        .then((value) {
      dynamic resp = jsonDecode(value.body);
      transferencias = resp['data'];
      montoDouble = 0.0;
      for (var i = 0; i < transferencias.length; i++) {
        if (transferencias[i]['type'] == 'Recarga') {
          montoDouble += double.parse(transferencias[i]['amount']);
        } else {
          montoDouble -= double.parse(transferencias[i]['amount']);
        }
      }
      monto.text = montoDouble.toStringAsFixed(3);

      print(value.body);
    });
  }

  Future saveTranferencia() async {
    if (montoDouble >= double.parse(montoTransferencia.text)) {
      Map<String, String> body = {
        'user_id': user['id'].toString(),
        'type': tipo.dropDownValue!.value,
        'amount': montoTransferencia.text
      };

      await Service.consulta('transactions', 'post', body).then((value) {
        print(value.body);
      });
    } else {
      showDialog(
          context: context!,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No tienes saldo suficiente',
                      style: TextStyle(
                          color: ColorsApp.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    MaterialButton(
                      color: ColorsApp.background,
                      onPressed: () {
                        Navigator.pop(context); // Cierra el diálogo de error

                        // Luego, realiza la carga o la acción que desees
                      },
                      child: Text(
                        'Aceptar',
                        style: TextStyle(color: ColorsApp.white),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }
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
