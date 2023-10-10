import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tafur/src/pages/bet/bet_controller.dart';
import 'package:tafur/src/utils/colors.dart';

class BetScreen extends StatefulWidget {
  const BetScreen({super.key});

  @override
  State<BetScreen> createState() => _BetScreenState();
}

class _BetScreenState extends State<BetScreen> {
  BetController con = BetController();
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
          backgroundColor: ColorsApp.white,
          title: Text(
            'Detalle de apuesta',
            style:
                TextStyle(color: ColorsApp.black, fontWeight: FontWeight.bold),
          ),
          foregroundColor: ColorsApp.black,
        ),
      ),
    );
  }
}
