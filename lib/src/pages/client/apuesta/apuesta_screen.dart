import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/client/apuesta/apuesta_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class ApuestaScreen extends StatefulWidget {
  const ApuestaScreen({super.key});

  @override
  State<ApuestaScreen> createState() => _ApuestaScreenState();
}

class _ApuestaScreenState extends State<ApuestaScreen> {
  ApuestaController con = ApuestaController();
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
        appBar: AppBar(
          foregroundColor: ColorsApp.black,
          backgroundColor: ColorsApp.white,
          title: Text(
            'Detalle de Apuesta',
            style: TextStyle(
                color: ColorsApp.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            /*Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              alignment: Alignment.center,
              width: size!.width * 1,
              child: Text(
                'DETALLE DE APUESTAS',
                style: TextStyle(
                    color: ColorsApp.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
            ),*/
            /*Expanded(
                child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    width: size!.width * 1.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://depor.com/resizer/bp0-3vhUuw12xTWyX7WaOjCDXU4=/580x330/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/YRFBTBFFD5GCFK3TEHAEOUR5UQ.jpg'),
                            fit: BoxFit.fitWidth),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1.0, color: ColorsApp.black)),
                  ),
                ],
              ),
            ))*/
          ],
        ),
      ),
    );
  }
}
