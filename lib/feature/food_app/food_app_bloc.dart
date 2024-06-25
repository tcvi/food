import 'package:config_env/domain/repository/notify_service.dart';
import 'package:config_env/domain/utils/enums.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

part 'food_app_event.dart';
part 'food_app_state.dart';

class FoodAppBloc extends Bloc<FoodAppEvent, FoodAppState> {
  final notifyService = GetIt.I.get<NotifyService>();

  FoodAppBloc(AppThemeMode mode) : super(FoodAppState(mode: mode)) {
    on<HandleNotifyFromTerminal>((event, emit) async {
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      if (initialMessage != null) {
        notifyService.handleOpenFromTerminal();
      }
    });
  }
}
