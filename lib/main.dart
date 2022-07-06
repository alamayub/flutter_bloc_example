import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/api/login_api.dart';
import 'package:flutter_bloc_test/api/notes_api.dart';
import 'package:flutter_bloc_test/bloc/aap_state.dart';
import 'package:flutter_bloc_test/bloc/actions.dart';
import 'package:flutter_bloc_test/bloc/app_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/dialogs/generic_dialogs.dart';
import 'package:flutter_bloc_test/dialogs/loading_screen.dart';
import 'package:flutter_bloc_test/models.dart';
import 'package:flutter_bloc_test/strings.dart';
import 'package:flutter_bloc_test/views/iterable_list.dart';
import 'package:flutter_bloc_test/views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi(),
        notesApi: NotesApi(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(homePage),
        ),
        body: BlocConsumer<AppBloc, AppState>(
          listener: (context, appState) {
            // loadin screen
            if (appState.isLoading) {
              LoadingScreen.instance().show(context: context, text: pleaseWait);
            } else {
              LoadingScreen.instance().hide();
            }
            // display possible errors
            final loginError = appState.logoinError;
            if (loginError != null) {
              showGenericDialog(
                context: context,
                title: loginErrorDialogTitle,
                content: loginErrorDialogContent,
                optionBuilder: () => {
                  ok: true,
                },
              );
            }
            // logged in
            if (appState.isLoading == false &&
                appState.logoinError == null &&
                appState.loginHandle == const LoginHandle.fooBar() &&
                appState.fetchNotes == null) {
              context.read<AppBloc>().add(const LoadNotesAction());
            }
          },
          builder: (context, appState) {
            final notes = appState.fetchNotes;
            if (notes == null) {
              return LoginView(
                onLoginTapped: (email, password) {
                  context.read<AppBloc>().add(
                        LoginAction(
                          email: email,
                          password: password,
                        ),
                      );
                },
              );
            } else {
              return notes.toListView();
            }
          },
        ),
      ),
    );
  }
}
