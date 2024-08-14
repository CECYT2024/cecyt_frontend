import 'package:app_cecyt/core/cubit/global_cubit.dart';
import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/domain/register_params.dart';
import 'package:app_cecyt/features/auth/presentation/cubit/register_cubit.dart';
import 'package:app_cecyt/features/auth/presentation/pages/login_page.dart';
import 'package:app_cecyt/utils/widgets/custom_password_field.dart';
import 'package:app_cecyt/utils/widgets/custom_text_field.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static const path = '/register';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(
        repository: ApiRepository(
          apiProvider: AuthApiDataSource(),
        ),
      ),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with SingleTickerProviderStateMixin {
  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  late AnimationController controller;

  late Animation<double> animation;

  final GlobalKey<FormState> _key = GlobalKey();

  String _matricula = '';
  String _email = '';
  String _name = '';
  String _lastName = '';

  String _contrasena = '';

  String mensaje = '';

  bool tiempo = false;

  final matriculaCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final namesCtrl = TextEditingController();
  final lastNamesCtrl = TextEditingController();

  final passCrl = TextEditingController();

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    if (kDebugMode) {
      matriculaCtrl.text = 'C06619';
      passCrl.text = 'Postman69!';
    }

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    matriculaCtrl.dispose();
    passCrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedLogo(animation: animation),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Inserte los siguientes datos para crear su cuenta',
                    textAlign: TextAlign.center,
                    // style: SafeGoogleFont(
                    //   'Oswald',
                    //   fontSize: 30 * ffem,
                    //   fontWeight: FontWeight.w400,
                    //   height: 1.4825 * ffem / fem,
                    //   color: const Color(0xffffffff),
                    // ),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // height: 20,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8, // 300.0, //size.width * .6,
                  child: BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if (state is RegisterErrorState) {
                        _showError(context, state.error);
                      }
                      if (state is RegisterSuccessState) {
                        matriculaCtrl.clear();
                        passCrl.clear();
                        emailCtrl.clear();
                        namesCtrl.clear();
                        lastNamesCtrl.clear();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Cuenta creada correctamente'),
                        ));
                        context.read<GlobalCubit>().setToken(state.userData.token);
                        // Navigator.of(context).pushReplacementNamed(QrPage.path);
                      }
                    },
                    builder: (context, state) =>
                        // print(state);
                        Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          CustomTextField(
                            controller: matriculaCtrl,
                            keyboard: TextInputType.text,
                            hint: '',
                            label: 'Matricula',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Introduzca una matricula';
                              }
                              return null;
                            },
                            maxLength: 20,
                            onSave: (text) => _matricula = text ?? '',
                          ),
                          CustomTextField(
                            controller: emailCtrl,
                            keyboard: TextInputType.emailAddress,
                            hint: '',
                            label: 'Email',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Introduzca un correo valido';
                              }
                              return null;
                            },
                            maxLength: 40,
                            onSave: (text) => _email = text ?? '',
                          ),
                          CustomTextField(
                            controller: namesCtrl,
                            keyboard: TextInputType.text,
                            hint: '',
                            label: 'Nombres',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Introduzca un nombre';
                              }
                              return null;
                            },
                            maxLength: 20,
                            onSave: (text) => _name = text ?? '',
                          ),
                          CustomTextField(
                            controller: lastNamesCtrl,
                            keyboard: TextInputType.text,
                            hint: '',
                            label: 'Apellidos',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Introduzca un apellido';
                              }
                              return null;
                            },
                            maxLength: 20,
                            onSave: (text) => _lastName = text ?? '',
                          ),
                          CustomPasswordTextField(
                            controller: passCrl,
                            hint: '',
                            label: 'Contraseña',
                            maxLength: 100,
                            onSave: (text) => _contrasena = text ?? '',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state is RegisterProgressState)
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          else
                            PrincipalButton(
                              titulo: 'Crear usuario',
                              color: Colors.black,
                              callback: () {
                                // FocusScope.of(context).unfocus();

                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_key.currentState!.validate()) {
                                  _key.currentState!.save();

                                  context.read<RegisterCubit>().register(
                                        RegisterParams(
                                          studentID: _matricula,
                                          email: _email,
                                          name: _name,
                                          lastname: _lastName,
                                          password: _contrasena,
                                        ),
                                      );
                                }
                              },
                            ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
