import 'package:config_env/domain/utils/enums.dart';
import 'package:config_env/resources/colors/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../navigator/navigator.dart';
import 'food_app_bloc.dart';

class FoodAppWidget extends StatefulWidget {
  final AppThemeMode themeMode;

  const FoodAppWidget({super.key, required this.themeMode});

  @override
  State<FoodAppWidget> createState() => _FoodAppWidgetState();
}

class _FoodAppWidgetState extends State<FoodAppWidget> {
  late final FoodAppBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = FoodAppBloc(widget.themeMode);
    bloc.add(HandleNotifyFromTerminal());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FoodAppBloc>(
      create: (_) => bloc,
      child: BlocBuilder<FoodAppBloc, FoodAppState>(
        builder: (context, state) {
          return MaterialApp.router(
            theme: ThemeData(
              colorScheme: ColorScheme.light(primary: Colors.orange[500]!),
            ).copyWith(
              extensions: <ThemeExtension<dynamic>>[lightColorTheme],
            ),
            darkTheme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.black,
              extensions: <ThemeExtension<dynamic>>[darkColorTheme],
            ),
            themeMode: state.themMode,
            routerConfig: router,
            // home: const SplashWidget(),
          );
        },
      ),
    );
  }
}
