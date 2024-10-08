import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.title,
    required this.imageassetpath,
    required this.onTap,
  });

  final String imageassetpath;
  final String title;

  final String onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 10,
              blurRadius: 20,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: ElevatedButton(
          onLongPress: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 21, 98, 160),
            backgroundColor: Colors.white,
            elevation: 0,
            overlayColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(onTap);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20), // Ajustar el borde de la imagen
                  child: Image.asset(
                    imageassetpath,
                    // Ajustar la imagen para cubrir el área
                  ),
                ),
              ),
              const SizedBox(height: 1),
              Text(
                overflow: TextOverflow.ellipsis,
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
