import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

// upload image event
@immutable
class AppEventUploadImage implements AppEvent {
  final String filePathToUpload;
  const AppEventUploadImage({required this.filePathToUpload});
}

// delete account event
@immutable
class AppEventDeleteAccount implements AppEvent {
  const AppEventDeleteAccount();
}

// logout user event
@immutable
class AppEventLogout implements AppEvent {
  const AppEventLogout();
}

// initialize app state and firebase event
@immutable
class AppEventInitialize implements AppEvent {
  const AppEventInitialize();
}

// login event
@immutable
class AppEventLogin implements AppEvent {
  final String email;
  final String password;
  const AppEventLogin({
    required this.email,
    required this.password,
  });
}

// goto registration page from login
@immutable
class AppEventGoToRegistration implements AppEvent {
  const AppEventGoToRegistration();
}

// goto login from registration page
@immutable
class AppEventGoToLogin implements AppEvent {
  const AppEventGoToLogin();
}

// create user (registration event)
@immutable
class AppEventRegister implements AppEvent {
  final String email;
  final String password;
  const AppEventRegister({
    required this.email,
    required this.password,
  });
}
