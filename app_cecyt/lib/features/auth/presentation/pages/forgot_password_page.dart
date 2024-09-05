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
      child: ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomNavCentro(),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: ForgotPasswordForm(),
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

  // String _matricula = '';

  // String _contrasena = '';

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
        // onSave: (text) => _matricula = text ?? '',
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
          if (value == null || value.isEmpty) {
            return 'Introduzca un correo';
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
        label: 'codigo enviado al correo',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Introduzca un codigo';
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
          if (value == null || value.isEmpty) {
            return 'Introduzca un correo';
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
      ),
      CustomPasswordTextField(
        controller: confirmPassCrl,
        hint: '',
        label: 'Contraseña',
        maxLength: 100,
        onSave: (text) {},
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
                  AnimatedLogo(animation: animation),
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
                    // height: 20,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *
                    .8, // 300.0, //size.width * .6,
                child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordErrorState) {
                      context.showPopup(
                        closeOnPressed: () => Navigator.of(context).pop(),
                        type: DialogTypeEnum.error,
                        message: state.message,
                      );
                    }
                    if (state is ForgotPasswordSuccessState) {
                      matriculaCtrl.clear();
                      passCrl.clear();
                      // context.showPopup(
                      //   closeOnPressed: () => Navigator.of(context).pop(),
                      //   type: DialogTypeEnum.information,
                      //   message: state.message,
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          duration: const Duration(seconds: 3),
                        ),
                      );

                      // Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgotPasswordLoadingState)
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
                      );
                    if (state is ForgotPasswordErrorState) {
                      return Center(
                        child: Text(state.message),
                      );
                    }
                    return Form(
                      key: _key,
                      child: Column(
                        children: <Widget>[
                          if (state is ForgotPasswordInitialState)
                            ...initialForm(),
                          if (state is ForgotPasswordConfirmPageState)
                            ...confirmForm(),
                          PrincipalButton(
                            titulo: state is ForgotPasswordInitialState
                                ? 'Solictar'
                                : 'Enviar',
                            color: Colors.black,
                            callback: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_key.currentState!.validate()) {
                                _key.currentState!.save();
                                if (state is ForgotPasswordInitialState) {
                                  context.read<ForgotPasswordCubit>().sendEmail(
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
