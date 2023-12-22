import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/admin/users/edit_user_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  EditUserController con = EditUserController();
  Size? size;

  void nuevaTransaccion() {
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
                  DropDownTextField(
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
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: con.montoTransferencia,
                    decoration: InputDecoration(
                      hintText: '0',
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
                          Navigator.pop(context);
                          await con.saveTranferencia();
                          await con.getTranferencias();
                          con.cerrarModal();
                          setState(() {});
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
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      Map user = ModalRoute.of(context)!.settings.arguments as Map;
      await con.init(context, user);
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
            'Saldo de Usuario',
            style:
                TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          foregroundColor: ColorsApp.black,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: ClipRect(
                      child: Image.asset(
                        'assets/perfil.png',
                        height: 130.0,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          readOnly: true,
                          controller: con.names,
                          decoration: InputDecoration(
                            hintText: 'Nombres',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
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
                        child: TextField(
                          readOnly: true,
                          controller: con.monto,
                          decoration: InputDecoration(
                            hintText: 'Monto',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
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
                    ],
                  ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: MaterialButton(
                onPressed: () async =>
                    nuevaTransaccion(), //con.registrarUsuario(),
                color: ColorsApp.background,
                height: 45.0,
                minWidth: size!.width * 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Nueva Transaccion',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: ColorsApp.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              padding: EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                children: [
                  Container(
                    width: 50.0,
                    alignment: Alignment.center,
                    child: Text('Nombres'),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Tipo de transacción'),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.center,
                    child: Text('Monto'),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    width: size!.width * 1,
                    child: ListView(
                      children: listTransacciones(),
                    )))
          ],
        ),
        /*body: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: ClipRect(
                    child: Image.asset(
                      'assets/perfil.png',
                      height: 130.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: con.names,
                          decoration: InputDecoration(
                            hintText: 'Nombres',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
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
                        child: TextField(
                          controller: con.email,
                          decoration: InputDecoration(
                            hintText: 'email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
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
                      /*Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: con.password,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color:
                                      ColorsApp.background), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color:
                                      ColorsApp.background), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: MaterialButton(
                          onPressed: () async =>
                              {}, //con.registrarUsuario(),
                          color: ColorsApp.background,
                          height: 45.0,
                          minWidth: size!.width * 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            'Registrar',
                            style: TextStyle(
                                fontSize: 18.0,
                                color: ColorsApp.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )*/
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
              child: MaterialButton(
                onPressed: () async => {}, //con.registrarUsuario(),
                color: ColorsApp.background,
                height: 45.0,
                minWidth: size!.width * 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Nueva Transaccion',
                  style: TextStyle(
                      fontSize: 18.0,
                      color: ColorsApp.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0),
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
                      child: Text('Tipo de transacción'),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    alignment: Alignment.center,
                    child: Text('Monto'),
                  ),
                  Expanded(
                      child: Container(
                    width: size!.width * 1,
                    child: ListView(
                      children: [],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),*/
      ),
    );
  }

  List<Widget> listTransacciones() {
    List<Widget> opt = [];

    for (var i = 0; i < con.transferencias.length; i++) {
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
              child: Text('${con.transferencias[i]['type']}'),
            ),
          ),
          Container(
            width: 100.0,
            alignment: Alignment.center,
            child: Text('${con.transferencias[i]['amount']}'),
          ),
        ],
      );
      opt
        ..add(temp)
        ..add(Divider());
    }
    return opt;
  }
}
