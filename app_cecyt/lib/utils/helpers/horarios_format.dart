import 'package:flutter/material.dart';

class HorarioContainer extends StatelessWidget {
  const HorarioContainer(this.sala, this.hora, this.speaker, this.title, {super.key});

  final String sala;
  final String hora;
  final String speaker;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border(
          top: BorderSide(width: 1.0, color: Color.fromARGB(54, 0, 0, 0)),
          bottom: BorderSide(width: 1.0, color: Color.fromARGB(53, 0, 0, 0)),
        ),
      ),
      padding: const EdgeInsets.all(7.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                sala,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 19, 156, 224),
                ),
              ),
              Text(
                hora,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  speaker,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
