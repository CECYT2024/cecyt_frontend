import 'package:app_cecyt/core/cubit/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppbarCentro extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCentro({super.key, this.isHome = false});

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 75,
          actions: state is SessionLoaded && isHome
              ? [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: context.read<SessionCubit>().logout,
                  ),
                ]
              : null,
          centerTitle: true,
          title: Image.asset(
            'assets/cecytlogo.png',
            height: 75,
            width: 75,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
