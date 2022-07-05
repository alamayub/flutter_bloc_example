import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_test/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final LogoinErrors? logoinError;
  final LoginHandle? loginHandle;
  final Iterable<Note>? fetchNotes;

  const AppState.empty()
      : isLoading = false,
        logoinError = null,
        loginHandle = null,
        fetchNotes = null;

  const AppState({
    required this.isLoading,
    required this.logoinError,
    required this.loginHandle,
    required this.fetchNotes,
  });

  @override
  String toString() => {
        'isLoading': isLoading,
        'loginError': logoinError,
        'loginHandle': loginHandle,
        'fetchNotes': fetchNotes
      }.toString();
}
