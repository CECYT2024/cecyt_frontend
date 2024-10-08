import 'package:app_cecyt/core/cubit/global_cubit.dart';
import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:app_cecyt/core/extensions/build_context_extension.dart';
import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/presentation/bloc/login_bloc.dart';
import 'package:app_cecyt/features/auth/presentation/pages/pages.dart';
import 'package:app_cecyt/features/auth/presentation/pages/register_page.dart';
import 'package:app_cecyt/utils/widgets/custom_password_field.dart';
import 'package:app_cecyt/utils/widgets/custom_text_field.dart';
import 'package:app_cecyt/utils/widgets/principal_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const path = '/login';

  @override
  Widget build(BuildContext context) {
    // return const BasePage(title: 'Iniciar Sesion', child: LoginView());
    return Scaffold(
      backgroundColor: Colors.white,
      // bottomNavigationBar: BottomNavCentro(),
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginBloc(ApiRepository(apiProvider: AuthApiDataSource())),
      child: const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> animation;

  final GlobalKey<FormState> _key = GlobalKey();

  String _matricula = '';

  String _contrasena = '';

  String mensaje = '';

  bool tiempo = false;
  final matriculaCtrl = TextEditingController();
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
                  'Inserte matricula y clave',
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
                width: MediaQuery.of(context).size.width *
                    .8, // 300.0, //size.width * .6,
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginErrorState) {
                      context.showPopup(
                          closeOnPressed: () => Navigator.of(context).pop(),
                          type: DialogTypeEnum.error,
                          message: state.message);
                    }
                    if (state is LoggedState) {
                      matriculaCtrl.clear();
                      passCrl.clear();
                      context
                          .read<GlobalCubit>()
                          .setToken(state.data.accessToken);
                      context.read<SessionCubit>().setSession(
                          state.data.accessToken,
                          state.data.isAdmin,
                          state.data.expiresIn);
                      // Navigator.of(context)
                      //     .pushReplacementNamed(StartPage.path);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    }
                  },
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (BuildContext context, LoginState state) {
                      // print(state);
                      return Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                              maxLength: 10,
                              onSave: (text) => _matricula = text ?? '',
                            ),
                            CustomPasswordTextField(
                              controller: passCrl,
                              hint: '',
                              label: 'Contraseña',
                              maxLength: 100,
                              onSave: (text) => _contrasena = text ?? '',
                            ),
                            // Importar el paquete para copiar al portapapeles

// Dentro de la clase _LoginFormState, en el método build:
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(RegisterPage.path),
                                    child: Text(
                                      textScaler: const TextScaler.linear(0.7),
                                      'Nueva cuenta',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context)
                                        .pushNamed(ForgotPasswordPage.path),
                                    child: Text(
                                      textScaler: const TextScaler.linear(0.7),
                                      'Olvide mi contraseña',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (state is LoginProgressState)
                              const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            else
                              PrincipalButton(
                                titulo: 'Ingresar',
                                color: Colors.black,
                                callback: () {
                                  // FocusScope.of(context).unfocus();

                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (_key.currentState!.validate()) {
                                    _key.currentState!.save();

                                    context.read<LoginBloc>().add(
                                          DoLoginEvent(_matricula, _contrasena),
                                        );
                                  }
                                },
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.support_agent,
                                    size: 15, color: Colors.green),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Clipboard.setData(const ClipboardData(
                                          text: 'ucacecyt@gmail.com'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Email copiado al portapapeles')),
                                      );
                                    },
                                    child: Text(
                                      textScaler: const TextScaler.linear(0.7),
                                      '¿Necesitas soporte? Escríbenos al email',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Colors.green,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                      overflow: TextOverflow
                                          .ellipsis, // Esto asegura que el texto no se desborde
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({required this.animation, super.key})
      : super(listenable: animation);
  // Maneja los Tween estáticos debido a que estos no cambian.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 150);

  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    // final Animation<double> animation = animation;
    return Opacity(
      opacity: _opacityTween.evaluate(animation),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: _sizeTween.evaluate(animation), // Aumenta la altura
        width: _sizeTween.evaluate(animation), // Aumenta el ancho
        child: const CECYTLogo(imagePath: 'assets/cecytlogo.png'),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(image: AssetImage('assets/logo.png')),
        // ),
      ),
    );
  }
}

class CECYTLogo extends StatelessWidget {
  final String imagePath;

  const CECYTLogo({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath);
  }
}
