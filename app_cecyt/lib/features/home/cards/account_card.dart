import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/home/ui/start/start_page.dart';
import 'package:app_cecyt/utils/widgets/appbar_centro.dart';
import 'package:flutter/material.dart';
import 'package:app_cecyt/utils/helpers/api_service.dart';
import '../../../utils/helpers/pref_manager.dart';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCard extends StatefulWidget {
  const AccountCard({super.key});
  static const String path = '/account';

  @override
  _AccountCardState createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  late Future<Map<String, dynamic>> userData;
  String? qrUrl;
  String? name;
  String? lastname;
  String? studentId;
  String? email;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    userData = _fetchUserData();
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
        email = userData['email'];
      });
      return userData;
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppbarCentro(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text(errorMessage ?? 'Error al obtener los datos'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Nombre: $name $lastname',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Email: $email', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 8),
                  Text('Matricula: $studentId',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: confirmDelete,
                    child: const Text('Borrar Cuenta',
                        style:
                            TextStyle(color: Color.fromARGB(255, 21, 98, 161))),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }

  void confirmDelete() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            title: const Text('Confirmar eliminación de cuenta'),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'SI ELIMINA SU CUENTA NO PODRÁ RECUPERARLA. Perdera acceso al INNOTEC'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancelar',
                    style: TextStyle(color: Color.fromARGB(255, 21, 98, 161))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Borrar cuenta',
                    style: TextStyle(color: Color.fromARGB(255, 21, 98, 161))),
                onPressed: () {
                  Navigator.of(context).pop();
                  _confirmDeleteAccount();
                },
              ),
            ],
          );
        });
  }

  void _confirmDeleteAccount() {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text('Confirmar eliminación de cuenta'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                  'Ingrese su contraseña y escriba CONFIRMAR para eliminar la cuenta.'),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              TextField(
                controller: confirmController,
                decoration: const InputDecoration(labelText: 'CONFIRMAR'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar',
                  style: TextStyle(color: Color.fromARGB(255, 21, 98, 161))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Borrar cuenta',
                  style: TextStyle(color: Color.fromARGB(255, 21, 98, 161))),
              onPressed: () {
                if (confirmController.text == 'CONFIRMAR') {
                  _deleteUser(passwordController.text);
                  Navigator.of(context)
                      .pop(); // Cerrar el diálogo después de confirmar
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Debe escribir CONFIRMAR para continuar.'),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(String password) {
    final token = PrefManager(null).token ?? '';
    ApiRepository(apiProvider: AuthApiDataSource())
        .deleteUser(token, password)
        .then((value) {
      context.read<SessionCubit>().logout();
      Navigator.of(context).popUntil((route) => route.isFirst);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cuenta eliminada'),
        ),
      );
    }).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
        ),
      );
    });
  }
}
