import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_test/models.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();
  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  // const LoginApi._sharedIntance();
  // static const LoginApi _shared = LoginApi._sharedIntance();
  // factory LoginApi.intance() => _shared;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 3),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then((value) => value ? const LoginHandle.fooBar() : null);
}
