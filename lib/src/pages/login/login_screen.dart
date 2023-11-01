import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/login/login_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final LoginController con = LoginController();
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
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size!.height * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size!.width * 0.10),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/IcoBlanco.png',
                          //height: 150,
                        ),
                        Text(
                          con.titulo,
                          style: TextStyle(
                              color: ColorsApp.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w500),
                        ),
                        expaciado(size!.height * 0.07),
                        TextField(
                          controller: con.usuario,
                          style: TextStyle(color: ColorsApp.background),
                          decoration: InputDecoration(
                            fillColor: ColorsApp.white,
                            filled: true,
                            hintText: 'Usuario',
                            hintStyle: TextStyle(color: ColorsApp.background),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorsApp.borderInput), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorsApp.borderInput), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorsApp.borderInput), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                          ),
                        ),
                        expaciado(size!.height * 0.025),
                        TextField(
                          controller: con.password,
                          obscureText: _obscureText,
                          style: TextStyle(color: ColorsApp.background),
                          decoration: InputDecoration(
                            fillColor: ColorsApp.white,
                            filled: true,
                            hintText: 'Contraseña',
                            hintStyle: TextStyle(color: ColorsApp.background),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorsApp.borderInput), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorsApp.borderInput), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ColorsApp.background,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                }),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: ColorsApp.borderInput), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(9.0),
                            ),
                          ),
                        ),
                        expaciado(size!.height * 0.05),
                        MaterialButton(
                          minWidth: size!.width * 1,
                          height: 42.0,
                          onPressed: () async => await con.login(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.0),
                              side: BorderSide(
                                  color: ColorsApp.white, width: 2.0)),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        expaciado(size!.height * 0.01)
                      ],
                    ),
                  ),
                  expaciado(10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Registrate Aquí',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: ColorsApp.white,
                            fontWeight: FontWeight.bold),
                      ),
                      expaciado(5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () =>
                                  con.launchWhatsApp("+595985704200"),
                              child: Text(
                                'Whatsapp 01',
                                style: TextStyle(
                                  color: ColorsApp.white,
                                  fontSize: 15,
                                ),
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          TextButton(
                              onPressed: () =>
                                  con.launchWhatsApp("+595985904706"),
                              child: Text(
                                'Whatsapp 02',
                                style: TextStyle(
                                    color: ColorsApp.white, fontSize: 15),
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              copiRight()
            ],
          ),
        ),
      ),
    ));
  }

  Widget expaciado(double valor) {
    return SizedBox(
      height: valor,
    );
  }

  Widget copiRight() {
    return Text(
      con.copyRight,
      style: const TextStyle(color: Colors.white),
    );
  }
}
