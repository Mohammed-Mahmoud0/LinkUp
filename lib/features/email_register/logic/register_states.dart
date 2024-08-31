class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  String errorMessage;

  RegisterErrorState(this.errorMessage);
}

class RegisterIsObscureTextState extends RegisterStates {}
