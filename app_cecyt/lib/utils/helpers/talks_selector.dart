import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TalksSelector extends StatelessWidget {
  const TalksSelector({
    super.key,
    required this.sala,
    required this.hora,
    required this.speaker,
    required this.title,
    required this.onTap,
  });
  final String sala;
  final String hora;
  final String speaker;
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: Color.fromARGB(110, 0, 0, 0),
            blurRadius: 5,
            offset: const Offset(0, 0),
          )
        ],
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: CupertinoButton(
        onPressed: () {
          onTap();
        },
        child: Row(children: [
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
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 17,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  speaker,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.normal,
                    fontSize: 15,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
