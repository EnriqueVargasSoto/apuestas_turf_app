import 'package:flutter/material.dart';
import 'package:tafur/src/pages/client/nosotros/nosotros_controller.dart';

class NosotrosScreen extends StatefulWidget {
  const NosotrosScreen({super.key});

  @override
  State<NosotrosScreen> createState() => _NosotrosScreenState();
}

class _NosotrosScreenState extends State<NosotrosScreen> {
  NosotrosController con = NosotrosController();
  Size? size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SizedBox(
      width: size!.width * 1.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Quienes Somos',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Términos y condiciones',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: size!.width * 0.10),
              child: const Text(
                'Todos los jugadores (en adelante, el "usuario" o los "usuarios" ) que desean hacer uso de los servicios de juegos operados, en la modalidad online, estaran obligados a registrarse en el sitio web, y de aceptar los términos y condiciones establecidos en las condiciones generales de contratación que constituyen el contrato de juego con los usuarios finales. (En adelante, el "contrato de juego") así como en la política de privacidad contenida en el mismo en la versión que este publicada por el sitio web en el momento en el que el usuario acceda.',
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              'Bases',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 15.0, horizontal: size!.width * 0.10),
              child: Column(
                children: const [
                  Text(
                      '1: si un encuentro no se completa en un periodo de 72 horas de su momento de inicio planeado oficialmente, todas la apuestas sobre ese encuentro quedarán invalidadas.'),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                      '2: las determinaciones finales del resultado de un encuentro estarán a cargo del organismo regulador del encuentro en su fecha de finalización.')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
