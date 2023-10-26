import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:config_env/domain/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'food_app_event.dart';
part 'food_app_state.dart';

class FoodAppBloc extends Bloc<FoodAppEvent, FoodAppState> {
  FoodAppBloc(AppThemeMode mode) : super(FoodAppState(mode: mode)) {
    on<FoodAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
