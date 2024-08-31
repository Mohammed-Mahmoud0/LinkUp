import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/features/email_login/logic/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  bool isObscureText = true;

  LoginCubit() : super(LoginInitialState());

  void loginWithEmailAndPassword(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.emailVerified) {
        emit(LoginSuccessState());
      }
      else {
        emit(LoginErrorState('Please verify your email to continue.'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(LoginErrorState('Wrong email or password!'));
      }
    } catch (e) {
      emit(LoginErrorState('something went wrong 😔 please try again later.'));
    }
  }

  void changeObscureTextStatus() {
    isObscureText = !isObscureText;
    emit(LoginIsObscureTextState());
  }
}
