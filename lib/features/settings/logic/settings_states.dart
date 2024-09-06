class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class SettingsLoadingState extends SettingsStates {}

class GetUserDataSuccessState extends SettingsStates {}

class GetUserDataErrorState extends SettingsStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class UpdateUserDataSuccessState extends SettingsStates {
  final String message;

  UpdateUserDataSuccessState(this.message);
}

class UpdateUserDataErrorState extends SettingsStates {
  final String error;

  UpdateUserDataErrorState(this.error);
}
