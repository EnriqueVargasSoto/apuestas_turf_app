import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/admin/profile/profile_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController con = ProfileController();
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
    return SizedBox(
      width: size!.width * 1,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          width: size!.width * 1,
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Stack(
                  children: <Widget>[
                    ClipRect(
                      child: con.image != null
                          ? Column(children: [
                              Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: Image.file(con.image!).image,
                                          fit: BoxFit.cover))),
                            ])
                          : con.user['user']['name'] == null
                              ? Image.asset(
                                  'assets/perfil.png',
                                  height: 130.0,
                                )
                              : Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://apuestas-turf.com/storage/' +
                                                  con.user['user']['name']),
                                          fit: BoxFit.cover))),
                    ),
                    Positioned(
                        width: 45,
                        height: 45,
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () async {
                            await con.pickImage().then((value) {
                              print(con.user['user']['name']);
                              setState(() {});
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorsApp.background,
                                borderRadius: BorderRadius.circular(50)),
                            child: Icon(
                              Icons.edit,
                              color: ColorsApp.white,
                              size: 21.0,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: con.names,
                  decoration: InputDecoration(
                    hintText: 'Nombres',
                    label: Text('Nombres'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
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
                    hintText: 'usuario',
                    label: Text('Usuario'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: con.password,
                  //readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'password',
                    label: Text('Password'),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: ColorsApp.background), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),*/
              //Text('${con.user['role_id'].toString()}'),
              con.user['user']['role_id'] == '2'
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                              onPressed: () async =>
                                  con.launchWhatsApp("+595985704200"),
                              color: ColorsApp.background,
                              height: 45.0,
                              //minWidth: size!.width * 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.whatsapp,
                                    color: ColorsApp.white,
                                  ),
                                  Text(
                                    'Whatsapp 1',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: ColorsApp.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          SizedBox(
                            width: 10.0,
                          ),
                          MaterialButton(
                            onPressed: () async =>
                                con.launchWhatsApp("+595985904706"),
                            color: ColorsApp.background,
                            height: 45.0,
                            //minWidth: size!.width * 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.whatsapp,
                                  color: ColorsApp.white,
                                ),
                                Text(
                                  'Whatsapp 2',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: ColorsApp.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                  : Container(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: MaterialButton(
                  onPressed: () async => await con.updateNames(),
                  color: ColorsApp.background,
                  height: 45.0,
                  minWidth: size!.width * 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Guardar Cambios',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: ColorsApp.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: MaterialButton(
                  onPressed: () async => con.cerrarSesion(),
                  color: ColorsApp.background,
                  height: 45.0,
                  minWidth: size!.width * 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Cerrar Sesion',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: ColorsApp.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
