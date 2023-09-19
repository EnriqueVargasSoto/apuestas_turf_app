import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/admin/users/users_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UsersController con = UsersController();
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          width: size!.width * 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Usuarios',
                style: TextStyle(
                    color: ColorsApp.black,
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold),
              ),
              MaterialButton(
                color: ColorsApp.background,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: ColorsApp.black, width: 1.0)),
                onPressed: () => con.createUser(),
                child: Text(
                  'NUEVO USUARIO',
                  style: TextStyle(color: ColorsApp.white, fontSize: 15.0),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Buscar usuario...',
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
                suffixIcon: Icon(
                  Icons.search,
                  color: ColorsApp.background,
                )),
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: ListView(
            children: listUsers(),
          ),
        ))
      ],
    );
  }

  List<Widget> listUsers() {
    List<Widget> opt = [];

    for (var i = 0; i < con.users.length; i++) {
      Widget temp = Container(
        //padding: EdgeInsets.symmetric(),
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: ColorsApp.background, width: 1.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  const SizedBox(
                    width: 15.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset(
                      "assets/perfil.png",
                      height: 40.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Text("${con.users[i]['names']}")
                ],
              ),
            ),
            SizedBox(
              child: Row(
                children: [
                  IconButton(
                      //padding: EdgeInsets.all(3.0),
                      onPressed: () => con.editUser(con.users[i]),
                      icon: Icon(
                        Icons.monetization_on,
                        color: ColorsApp.background,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: ColorsApp.background,
                      )),
                ],
              ),
            )
          ],
        ),
      );
      opt.add(temp);
    }

    return opt;
  }
}
