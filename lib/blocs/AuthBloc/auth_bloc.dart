import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../layout/screen_layout.dart';
import '../../resources/auth_methods.dart';
import '../../../screens/signin_screen.dart';
import '../../../utils/utils.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthMethods authMethods;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  AuthBloc(this.authMethods) : super(AuthInitial()) {
    on<SignUpUserEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await authMethods.signUpUser(
        name: event.name,
        address: event.address,
        email: event.emailId,
        password: event.password,
      );
      if (result == 'Registration Successful') {
        Utils().showsnackBar(
          context: event.context,
          message: result,
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => SigninScreen(),
          ),
        );
      } else {
        Utils().showsnackBar(
          context: event.context,
          message: result,
        );
      }
      emit(AuthLoaded());
    });
// To login user using existing email and password.

    on<SigninUserEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await authMethods.signInUser(
        email: event.email,
        password: event.password,
      );
      if (result == 'Login Successful') {
        Utils().showsnackBar(
          context: event.context,
          message: result,
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => ScreenLayout(),
          ),
        );
      } else {
        Utils().showsnackBar(
          context: event.context,
          message: result,
        );

        emit(AuthLoaded());
      }
    });
  }
}
