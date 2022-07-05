import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/api/login_api.dart';
import 'package:flutter_bloc_test/api/notes_api.dart';
import 'package:flutter_bloc_test/bloc/aap_state.dart';
import 'package:flutter_bloc_test/bloc/actions.dart';
import 'package:flutter_bloc_test/models.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    // handle login
    on<LoginAction>((event, emit) async {
      // start loading
      emit(
        const AppState(
          isLoading: true,
          logoinError: null,
          loginHandle: null,
          fetchNotes: null,
        ),
      );
      // login user
      final loginHandle = await loginApi.login(
        email: event.email,
        password: event.password,
      );
      emit(
        AppState(
          isLoading: false,
          logoinError: loginHandle == null ? LogoinErrors.invalidHandle : null,
          loginHandle: loginHandle,
          fetchNotes: null,
        ),
      );
    });

    // handle fetch notes
    on<LoadNotesAction>((event, emit) async {
      // start loading
      emit(
        AppState(
          isLoading: true,
          logoinError: null,
          loginHandle: state.loginHandle,
          fetchNotes: null,
        ),
      );
      // get the login hangle
      final loginHandle = state.loginHandle;
      // invalid login handle, can not fetch notes
      if (loginHandle != const LoginHandle.fooBar()) {
        emit(
          AppState(
            isLoading: false,
            logoinError: LogoinErrors.invalidHandle,
            loginHandle: loginHandle,
            fetchNotes: null,
          ),
        );
        return;
      }
      // we have a valid login handle and want to fetch notes
      final notes = await notesApi.getNotes(loginHandle: loginHandle!);
      emit(
        AppState(
          isLoading: false,
          logoinError: null,
          loginHandle: loginHandle,
          fetchNotes: notes,
        ),
      );
    });
  }
}
