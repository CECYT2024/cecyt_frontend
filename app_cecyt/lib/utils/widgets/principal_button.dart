import 'package:flutter/material.dart';

class PrincipalButton extends StatelessWidget {
  const PrincipalButton({
    required this.titulo,
    required this.color,
    required this.callback,
    this.colortexto = Colors.white,
    this.elevacion = 0,
    this.isIcon = false,
    this.icono,
    super.key,
    this.iconoPrincipal,
  });
  final String titulo;
  final IconData? icono;
  final IconData? iconoPrincipal;
  final void Function() callback;
  final Color color;
  final bool isIcon;
  final Color colortexto;
  final double elevacion;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ButtonTheme(
        minWidth: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(elevacion),
            backgroundColor: MaterialStatePropertyAll(color),
            textStyle: MaterialStatePropertyAll<TextStyle>(
              Theme.of(context).textTheme.headlineLarge!.copyWith(color: colortexto),
            ),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          onPressed: callback,
          // textColor: white,
          child: isIcon
              ? Icon(
                  iconoPrincipal,
                  color: colortexto,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(
                        titulo,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: colortexto),
                      ),
                    ),
                    if (icono != null)
                      Padding(
                        // padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        padding: EdgeInsets.zero,
                        child: Icon(
                          icono,
                        ),
                      )
                  ],
                ),
        ),
      ),
    );
  }
}
