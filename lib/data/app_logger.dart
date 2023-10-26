import 'package:config_env/domain/configs/logger.dart';
import 'package:logger/logger.dart';

class AppLogger extends Logger implements ILogger {
  AppLogger({
    LogFilter? filter,
    LogPrinter? printer,
    LogOutput? output,
    Level? level,
  }) : super(filter: filter, printer: printer, output: output, level: level);
}