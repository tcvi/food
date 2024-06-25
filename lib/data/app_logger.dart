import 'package:config_env/domain/configs/logger.dart';
import 'package:logger/logger.dart';

class AppLogger extends Logger implements ILogger {
  AppLogger({
    super.filter,
    super.printer,
    super.output,
    super.level,
  });
}