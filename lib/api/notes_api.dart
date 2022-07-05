import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_test/models.dart';

@immutable
abstract class NotesApiProtocol {
  const NotesApiProtocol();
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle});
}

@immutable
class NotesApi implements NotesApiProtocol {
  @override
  Future<Iterable<Note>?> getNotes({required LoginHandle loginHandle}) =>
      Future.delayed(
        const Duration(seconds: 3),
        () => loginHandle == const LoginHandle.fooBar() ? mockNotes : null,
      );
}
