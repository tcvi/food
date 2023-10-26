import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repository/storage_data.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final storageData = GetIt.I.get<StorageData>();
  SplashBloc() : super(const SplashState()) {
    on<InitEvent>((event, emit) async {
      await Future.delayed(const Duration(microseconds: 1000));
      if (storageData.token.isEmpty) {
        emit(state.copyWith(splashStep: SplashStep.login));
      } else {
        emit(state.copyWith(splashStep: SplashStep.home));
      }
    });
  }
}
