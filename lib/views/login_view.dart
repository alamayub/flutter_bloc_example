import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/bloc/app_bloc.dart';
import 'package:flutter_bloc_test/bloc/app_event.dart';
import 'package:flutter_bloc_test/extensions/if_debugging.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'toeato1@gmail.com'.ifDebugging);
    final passwordController =
        useTextEditingController(text: 'password'.ifDebugging);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration:
                const InputDecoration(hintText: 'Enter your email here...'),
            keyboardType: TextInputType.emailAddress,
            keyboardAppearance: Brightness.dark,
          ),
          TextField(
            controller: passwordController,
            decoration:
                const InputDecoration(hintText: 'Enter your password here...'),
            keyboardType: TextInputType.visiblePassword,
            keyboardAppearance: Brightness.dark,
            obscureText: true,
            obscuringCharacter: '*',
          ),
          TextButton(
            onPressed: () {
              final email = emailController.text.trim();
              final password = passwordController.text.trim();
              context.read<AppBloc>().add(
                    AppEventLogin(
                      email: email,
                      password: password,
                    ),
                  );
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppBloc>().add(const AppEventGoToRegistration());
            },
            child: const Text('Not registered yet ? Register'),
          ),
        ],
      ),
    );
  }
}
