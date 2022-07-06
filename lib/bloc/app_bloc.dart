import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc_test/auth/auth_error.dart';
import 'package:flutter_bloc_test/bloc/app_event.dart';
import 'package:flutter_bloc_test/bloc/app_state.dart';
import 'package:flutter_bloc_test/utils/upload_image.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  // initializine AppBloc
  AppBloc()
      : super(
          const AppStateLoggedOut(
            isLoading: false,
          ),
        ) {
    // initialize app event
    on<AppEventInitialize>((event, emit) async {
      // get the current user
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
      } else {
        final images = await _getImages(user.uid);
        emit(
          AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
          ),
        );
      }
    });

    // goto registration screen
    on<AppEventGoToRegistration>((event, emit) {
      emit(const AppStateRegistrationView(isLoading: false));
    });

    // register user event
    on<AppEventRegister>((event, emit) async {
      emit(const AppStateRegistrationView(isLoading: true));
      final email = event.email;
      final password = event.password;
      try {
        final credentials = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        emit(
          AppStateLoggedIn(
            user: credentials.user!,
            images: const [],
            isLoading: false,
          ),
        );
      } on FirebaseAuthException catch (e) {
        emit(
          AppStateRegistrationView(
            isLoading: false,
            authError: AuthError.from(e),
          ),
        );
      } on FirebaseException {
        emit(const AppStateRegistrationView(isLoading: false));
      }
    });

    // goto login screen
    on<AppEventGoToLogin>((event, emit) {
      emit(const AppStateLoggedOut(isLoading: false));
    });

    // login user with email and password
    on<AppEventLogin>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      final email = event.email;
      final password = event.password;
      try {
        final credentials =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = credentials.user!;
        final images = await _getImages(user.uid);
        emit(
          AppStateLoggedIn(
            user: user,
            images: images,
            isLoading: false,
          ),
        );
      } on FirebaseAuthException catch (e) {
        emit(AppStateLoggedOut(
          isLoading: false,
          authError: AuthError.from(e),
        ));
      }
    });

    // upload image
    on<AppEventUploadImage>((event, emit) async {
      final user = state.user;
      // logout user if not user
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }
      // start loading process
      emit(
        AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: true,
        ),
      );

      final file = File(event.filePathToUpload);
      await uploadImage(file: file, userId: user.uid);
      // after upload is complete, grab the latest file references
      final images = await _getImages(user.uid);
      emit(
        AppStateLoggedIn(
          user: user,
          images: images,
          isLoading: false,
        ),
      );
    });

    // logout current user
    on<AppEventLogout>((event, emit) async {
      emit(const AppStateLoggedOut(isLoading: true));
      await FirebaseAuth.instance.signOut();
      emit(const AppStateLoggedOut(isLoading: false));
    });

    // delete user account along with all data
    on<AppEventDeleteAccount>((event, emit) async {
      final user = FirebaseAuth.instance.currentUser;
      // log the user out if we don't have a current user
      if (user == null) {
        emit(const AppStateLoggedOut(isLoading: false));
        return;
      }
      //  start loading
      emit(
        AppStateLoggedIn(
          user: user,
          images: state.images ?? [],
          isLoading: true,
        ),
      );
      // delete user images folder
      try {
        final files = await FirebaseStorage.instance.ref(user.uid).listAll();
        for (final item in files.items) {
          await item.delete().catchError((_) {});
        }
        await FirebaseStorage.instance
            .ref(user.uid)
            .delete()
            .catchError((_) {});
        await user.delete();
        await FirebaseAuth.instance.signOut();
        emit(const AppStateLoggedOut(isLoading: false));
      } on FirebaseAuthException catch (e) {
        emit(
          AppStateLoggedIn(
            user: user,
            images: state.images ?? [],
            isLoading: false,
            authError: AuthError.from(e),
          ),
        );
      } on FirebaseException {
        emit(const AppStateLoggedOut(isLoading: false));
      }
    });
  }

  // get images for specific user
  Future<Iterable<Reference>> _getImages(String uid) =>
      FirebaseStorage.instance.ref(uid).list().then((value) => value.items);
}
