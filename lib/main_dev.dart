import 'domain/utils/enums.dart';
import 'main.dart' as runner;

void main() async {
  runner.currentEnvironment = Environment.dev;
  await runner.main();
}
