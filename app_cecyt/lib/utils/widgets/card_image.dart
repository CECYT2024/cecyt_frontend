import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage(
      {super.key,
      required this.title,
      required this.imageassetpath,
      required this.onTap,
      this.escala = 5, //5 por default
      this.elevacion = 10, //10 por default
      this.fontScale = 1,
      this.alto = 150,
      this.ancho = 155});
  final double escala;
  final double fontScale;
  final double elevacion;
  final String imageassetpath;
  final String title;
  final double alto;
  final double ancho;
  final void Function() onTap;
//_showQuestions(event)
/*ListTile(
                        title: Text('${event.name}, ${event.speaker}'),
                        subtitle: Text(
                          'Día: ${DateFormat('dd/MM/yyyy').format(event.startTime)}, ${event.place}, Hora: ${DateFormat('HH:mm').format(event.startTime)}',
                        ),
                        onTap: () => _showQuestions(event),
                      ) */
  @override
  Widget build(BuildContext context) {
    return Container(
      height: alto,
      width: ancho,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: elevacion - 10,
            color: Color.fromARGB(110, 0, 0, 0),
            blurRadius: elevacion,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            backgroundColor: const MaterialStatePropertyAll(Colors.white)),
        onPressed: () {
          onTap();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 5),
              child: Image.asset(
                imageassetpath,
                scale: escala,
              ),
            ),
            Text(
              textScaler: TextScaler.linear(fontScale),
              title,
              style: const TextStyle(color: Color.fromARGB(255, 21, 98, 160)),
            )
          ],
        ),
      ),
    );
  }
}
