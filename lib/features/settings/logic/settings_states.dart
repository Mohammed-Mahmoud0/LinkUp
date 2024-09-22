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

class UpdateProfileImageSuccessState extends SettingsStates {
  final String message;

  UpdateProfileImageSuccessState(this.message);
}

class UpdateProfileImageErrorState extends SettingsStates {
  final String error;

  UpdateProfileImageErrorState(this.error);
}

class DeleteProfileImageSuccessState extends SettingsStates {
  final String message;
  DeleteProfileImageSuccessState(this.message);
}