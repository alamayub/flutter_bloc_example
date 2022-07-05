import 'package:flutter/foundation.dart';

@immutable
class LoginHandle {
  final String token;

  const LoginHandle({required this.token});

  const LoginHandle.fooBar() : token = 'foobar';

  @override
  bool operator ==(covariant LoginHandle other) => token == other.token;

  @override
  String toString() => 'Login Handle (token = $token)';
}

enum LogoinErrors { invalidHandle }

@immutable
class Note {
  final String title;
  const Note({required this.title});

  @override
  String toString() => 'Note (title = $title)';
}

final mockNotes = Iterable.generate(3, (i) => Note(title: 'Note ${i + 1}'));


