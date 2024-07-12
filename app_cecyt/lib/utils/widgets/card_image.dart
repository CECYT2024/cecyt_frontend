import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.title,
    required this.imageassetpath,
    required this.onTap,
    this.escala = 5, //5 por default
    this.elevacion = 10, //10 por default
  });
  final double escala;
  final double elevacion;
  final String imageassetpath;
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStatePropertyAll(elevacion),
        shape: const WidgetStatePropertyAll(
          ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        backgroundColor: const WidgetStatePropertyAll(Colors.white),
      ),
      onPressed: () {
        onTap();
      },
      child: Column(
        children: [
          Image.asset(
            imageassetpath,
            scale: escala,
          ),
          Text(
            textScaler: const TextScaler.linear(1),
            title,
            style: const TextStyle(color: Color.fromARGB(255, 21, 98, 160)),
          )
        ],
      ),
    );
  }
}
