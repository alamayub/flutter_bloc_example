import 'package:flutter/foundation.dart%20';

@immutable
abstract class AppEvent {
  const AppEvent();
}

@immutable
class LoadNextUrlEvent implements AppEvent {
  const LoadNextUrlEvent();
}
