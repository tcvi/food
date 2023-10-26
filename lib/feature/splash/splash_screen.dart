import 'package:config_env/feature/splash/splash_bloc.dart';
import 'package:config_env/resources/assets/app_image_widget.dart';
import 'package:config_env/resources/assets/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../resources/colors/color_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).extension<ColorAppTheme>()!;
    return Scaffold(
      backgroundColor: colorTheme.splashColor,
      body: BlocProvider(
        create: (context) => SplashBloc()..add(InitEvent()),
        child: BlocListener<SplashBloc, SplashState>(
          listenWhen: (prev, curr) => prev.splashStep != curr.splashStep,
          listener: (context, state) {
            switch(state.splashStep) {
              case SplashStep.login:
                return context.pushReplacement('/login');
              case SplashStep.home:
                 context.go('/home');
                 return;
              default:
                break;
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return const Center(
                child: AppImageWidget(
                  url: ImagesPath.icSplash,
                  width: 192,
                  height: 192,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
