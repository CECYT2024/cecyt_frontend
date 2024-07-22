import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});
  static const String path = '/QRpage';

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  final String qrUrl =
      'https://api.qrserver.com/v1/create-qr-code/?size=512x512&data=https%3A%2F%2Fscript.google.com%2Fmacros%2Fs%2FAKfycbxZc2Qx4NfufZAmpXiLIp0P0n8kgIUufrsFp-Dv1oIG04HPRAzxjkchf0FpdnzUvBsw%2Fexec%3FMatricula%3DY11524%26Nombre%3DFede%26Apellido%3DAlonso%26Numero%3D993388897%26Email%3Dfederi.al2001%40gmail.com';

  @override
  void initState() {
    super.initState();
    _secureScreen();
  }

  @override
  void dispose() {
    _unsecureScreen();
    super.dispose();
  }

  Future<void> _secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<void> _unsecureScreen() async {
    await FlutterWindowManager.clearFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              qrUrl,
              width: 512,
              height: 512,
            ),
            const SizedBox(height: 20),
            const Text(
              'Escanea este código QR',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
