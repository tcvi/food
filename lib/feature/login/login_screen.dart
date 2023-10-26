import 'package:config_env/domain/repository/storage_data.dart';
import 'package:config_env/feature/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (_, state) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Login Screen'),
                ElevatedButton(
                    onPressed: () {
                      GetIt.I.get<StorageData>().setToken("TOKEN");
                      context.go('/home');
                    },
                    child: const Text('Go to Home'))
              ],
            ));
          },
        ),
      ),
    );
  }
}
