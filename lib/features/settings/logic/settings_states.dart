class SettingsStates {}

class SettingsInitialState extends SettingsStates {}

class SettingsLoadingState extends SettingsStates {}

class GetUserDataSuccessState extends SettingsStates {}

class GetUserDataErrorState extends SettingsStates {
  final String error;

  GetUserDataErrorState(this.error);
}
