import 'dart:io'; // Importar para manejar SocketException

import 'package:app_cecyt/core/extensions/build_context_extension.dart';
import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/domain/confirm_forgot_password_params.dart';
import 'package:app_cecyt/features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'package:app_cecyt/features/auth/presentation/pages/login_page.dart';
import 'package:app_cecyt/utils/widgets/custom_password_field.dart';
import 'package:app_cecyt/utils/widgets/custom_text_field.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  static const String path = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ForgotPasswordCubit(ApiRepository(apiProvider: AuthApiDataSource())),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: const ForgotPasswordForm(),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  final GlobalKey<FormState> _key = GlobalKey();

  String mensaje = '';

  bool tiempo = false;
  final matriculaCtrl = TextEditingController();
  final passCrl = TextEditingController();
  final confirmPassCrl = TextEditingController();
  final codeCrl = TextEditingController();
  final correoCrl = TextEditingController();

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

  List<Widget> initialForm() {
    return [
      CustomTextField(
        controller: matriculaCtrl,
        keyboard: TextInputType.text,
        hint: '',
        label: 'Matricula o C.I',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Introduzca una matricula o CI';
          }
          return null;
        },
        maxLength: 9,
        onSave: (text) {},
      ),
      const SizedBox(
        height: 20,
      ),
      CustomTextField(
        controller: correoCrl,
        keyboard: TextInputType.text,
        hint: '',
        label: 'Correo',
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !value.contains('@') ||
              !value.contains('.')) {
            return 'Introduzca un correo valido';
          }
          return null;
        },
        maxLength: 100,
        onSave: (text) {},
      ),
    ];
  }

  List<Widget> confirmForm() {
    return [
      CustomTextField(
        controller: codeCrl,
        keyboard: TextInputType.number,
        hint: '',
        label: 'Código enviado al correo',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Introduzca un código';
          } else if (value.length < 6) {
            return 'Mínimo 6 caracteres';
          }
          return null;
        },
        maxLength: 6,
        onSave: (text) {},
      ),
      const SizedBox(
        height: 20,
      ),
      CustomTextField(
        controller: correoCrl,
        keyboard: TextInputType.text,
        hint: '',
        label: 'Correo',
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              !value.contains('@') ||
              !value.contains('.')) {
            return 'Introduzca un correo valido';
          }
          return null;
        },
        maxLength: 100,
        onSave: (text) {},
      ),
      CustomPasswordTextField(
        controller: passCrl,
        hint: '',
        label: 'Contraseña',
        maxLength: 100,
        onSave: (text) => {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Introduzca una contraseña';
          } else if (value.length < 8) {
            return 'Mínimo 8 caracteres';
          }
          return null;
        },
      ),
      CustomPasswordTextField(
        controller: confirmPassCrl,
        hint: '',
        label: 'Confirmar contraseña',
        maxLength: 100,
        onSave: (text) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Introduzca una contraseña';
          } else if (value.length < 8) {
            return 'Mínimo 8 caracteres';
          } else if (value != passCrl.text) {
            return 'Las contraseñas no coinciden';
          }
          return null;
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedLogo2(animation: animation),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Completa los datos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    if (state is ForgotPasswordSuccessState) {
                      matriculaCtrl.clear();
                      passCrl.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          duration: const Duration(seconds: 3),
                          backgroundColor:
                              const Color.fromARGB(255, 52, 120, 55),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgotPasswordLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    }
                    return Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          if (state is ForgotPasswordInitialState)
                            ...initialForm(),
                          if (state is ForgotPasswordConfirmPageState ||
                              state is ForgotPasswordErrorState)
                            ...confirmForm(),
                          PrincipalButton(
                            titulo: state is ForgotPasswordInitialState
                                ? 'Solicitar'
                                : 'Enviar',
                            color: Colors.black,
                            callback: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                try {
                                  if (state is ForgotPasswordInitialState) {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .sendEmail(
                                          correoCrl.text,
                                          matriculaCtrl.text,
                                        );
                                  } else {
                                    context
                                        .read<ForgotPasswordCubit>()
                                        .confirmForgotPassword(
                                            ConfirmForgotPasswordParams(
                                          email: correoCrl.text,
                                          code: codeCrl.text,
                                          confirmPassword: confirmPassCrl.text,
                                          password: passCrl.text,
                                        ));
                                  }
                                } on SocketException {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'No se tiene conexión a Internet.'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo2 extends AnimatedWidget {
  const AnimatedLogo2({super.key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: animation.value * 100,
      width: animation.value * 100,
      child: const CECYTLogo(imagePath: 'assets/cecytlogo.png'),
    );
  }
}
