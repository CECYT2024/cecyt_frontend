import 'dart:io';

import 'package:app_cecyt/utils/constants.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import 'package:app_cecyt/utils/helpers/events_bloc.dart';
import 'package:app_cecyt/utils/helpers/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/widgets/bottom_nav_centro.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';


class QrPage extends StatefulWidget {
  const QrPage({super.key});
  static const String path = '/QRpage';

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  late Future<Map<String, dynamic>> userDataFuture;
  String? qrUrl;
  String? name;
  String? lastname;
  String? studentId;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    userDataFuture = _fetchUserData();
  }


  Future<Map<String, dynamic>> _fetchUserData() async {
    final apiService = ApiService();
    try {
      final userData =
          await apiService.getUserData(PrefManager(null).token ?? '');
      setState(() {
        qrUrl = userData['qr_link'];
        name = userData['name'];
        lastname = userData['lastname'];
        studentId = userData['student_id'];
      });
      return userData;
    } catch (e) {
      setState(() {
        errorMessage = EventsError(message: e.toString()) as String?;
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarCentro(),
      bottomNavigationBar: const BottomNavCentro(
        index: 2,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child:
                    Text(errorMessage ?? 'Inicie sesion para mostrar el QR'));
          } else if (snapshot.hasData) {
            if (qrUrl == null || qrUrl!.isEmpty) {
              return const Center(child: Text('No se tiene QR registrado'));
            }
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.no_photography_outlined),
                          Text(
                            ' No tomar fotos del QR',
                            style: TextStyle(
                                color: Color.fromARGB(255, 114, 115, 115)),
                          ),
                        ],
                      ),
                      Image.network(
                        qrUrl!,
                        width: 412,
                        height: 412,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Escanea este código QR',
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Nombre: $name $lastname',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Matricula: $studentId',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }
}
