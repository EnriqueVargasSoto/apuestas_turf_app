import 'package:flutter/material.dart';
/* import 'package:tafur/src/pages/statistics/statistics_controller.dart'; */
import 'package:tafur/src/utils/colors.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  Size? size;
  /* StatisticsController con = StatisticsController(); */

  @override
  void initState() {
    super.initState();
    /* con.init(); */
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsApp.white,
        title: Text(
          'Estadísticas',
          style: TextStyle(
            color: ColorsApp.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: ColorsApp.black,
      ),
      body: Column(
        children: [
          SizedBox(height: 15.0),
          Text(
            'Estadísticas generales',
            style: TextStyle(
              fontSize: 20.0,
              color: ColorsApp.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
            child: MaterialButton(
              /* enableFeedback: con.event['tag'] == 'Pendiente' ? false : true, */
              onPressed: () async {
                //con.saveEvent();
                /* con.event['tag'] == 'Pendiente' ? nuevaProbabilidad() : null; */
              }, //con.registrarUsuario(),

              color: ColorsApp.background,
              height: 45.0,
              minWidth: size!.width * 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                'Crear Estadistica',
                style: TextStyle(
                    fontSize: 18.0,
                    color: ColorsApp.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              /* child: ListView(
                children: [
                  _buildStatisticTile(
                    title: 'Usuarios registrados',
                    value: con.totalUsers.toString(),
                  ),
                  _buildStatisticTile(
                    title: 'Eventos creados',
                    value: con.totalEvents.toString(),
                  ),
                  _buildStatisticTile(
                    title: 'Probabilidades creadas',
                    value: con.totalProbabilities.toString(),
                  ),
                ],
              ), */
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticTile({required String title, required String value}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1.0, color: ColorsApp.background),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
