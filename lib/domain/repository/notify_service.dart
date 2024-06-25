import 'dart:async';

abstract class NotifyService {
  Future init();
  Future handleOpenFromTerminal();
}