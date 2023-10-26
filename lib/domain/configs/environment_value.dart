import '../utils/enums.dart';

abstract class EnvironmentValue<D> {
  D get dev;
  D get prod;

  D getData(Environment env) {
    switch (env) {
      case Environment.dev:
        return dev;
      case Environment.prod:
        return prod;
      default:
        return dev;
    }
  }
}