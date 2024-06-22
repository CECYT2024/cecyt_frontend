import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    super.key,
    required this.imageassetpath,
    required this.onTap,
  });

  final String imageassetpath;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(shape: WidgetStatePropertyAll(ContinuousRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))), backgroundColor: WidgetStatePropertyAll(Colors.white)),
      onPressed: () {},
      child: Column(
        children: [
          Image.asset(
            'assets/foto1.jpg',
            scale: 10,
          ),
          const Text('Cyt League')
        ],
      ),
    );
  }
}
