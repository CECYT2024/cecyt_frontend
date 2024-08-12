import 'package:app_cecyt/features/auth/data/api_datasource.dart';
import 'package:app_cecyt/features/auth/data/repositories/api_repository.dart';
import 'package:app_cecyt/features/auth/presentation/cubit/register_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
