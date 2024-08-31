import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/features/email_register/logic/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  bool isObscureText = true;

  RegisterCubit() : super(RegisterInitialState());

  void registerWithEmailAndPassword(String email, String password) async {
    emit(RegisterLoadingState());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterErrorState('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterErrorState('The account already exists for that email.'));
      }
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  void changeObscureTextStatus() {
    isObscureText = !isObscureText;
    emit(RegisterIsObscureTextState());
  }
}
