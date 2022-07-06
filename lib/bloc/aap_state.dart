import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_test/models.dart';
import 'package:collection/collection.dart';

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

  @override
  bool operator ==(covariant AppState other) {
    final otherPropertiesAreEqual = isLoading == other.isLoading &&
        logoinError == other.logoinError &&
        loginHandle == other.loginHandle;

    if (fetchNotes == null && other.fetchNotes == null) {
      return otherPropertiesAreEqual;
    } else {
      return otherPropertiesAreEqual &&
          (fetchNotes?.isEqualTo(other.fetchNotes) ?? false);
    }
  }

  @override
  int get hashCode => Object.hash(
        isLoading,
        logoinError,
        loginHandle,
        fetchNotes,
      );
}

extension UnorderedEquality on Object {
  bool isEqualTo(other) => const DeepCollectionEquality.unordered().equals(
        this,
        other,
      );
}
