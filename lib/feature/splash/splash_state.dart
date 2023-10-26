part of 'splash_bloc.dart';

@immutable
class SplashState {
  final SplashStep? splashStep;

  const SplashState({
    this.splashStep
  });

  SplashState copyWith({
    SplashStep? splashStep,
  }) {
    return SplashState(
      splashStep: splashStep ?? this.splashStep,
    );
  }
}

enum SplashStep { home, login }
