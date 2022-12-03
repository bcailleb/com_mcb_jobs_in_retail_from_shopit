import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../screens/sign_in_screen.dart';
import '../../../utils/utils.dart';
import '../../layout/screen_layout.dart';
import '../../resources/auth_methods.dart';
import '../../utils/exception_handler.dart';
import '../../utils/message_constant.dart';
import '../../utils/translate.dart';
import '../../utils/notifications.dart';

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

      if (result == constRegistrationSuccess) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        );
        sendSuccessNotification(
          context: event.context,
          message: translate(event.context)!.registration_successs,
        );
      } else {
        MessageHandler.authErrorAndException(
            context: event.context, errorMessage: result);
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
      if (result == constLoginSucces) {
        Utils().showsnackBar(
          context: event.context,
          message: translate(event.context)!.login_successful,
        );
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => ScreenLayout(),
          ),
        );
      } else {
        MessageHandler.authErrorAndException(
            context: event.context, errorMessage: result);
        emit(AuthLoaded());
      }
    });
  }
}
