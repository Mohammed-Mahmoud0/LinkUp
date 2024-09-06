class ChatsStates {}

class ChatsInitialState extends ChatsStates {}

class ChatsLoadingState extends ChatsStates {}

class ChatsSuccessLoadedState extends ChatsStates {}

class ChatsErrorState extends ChatsStates {
  final String? error;

  ChatsErrorState({this.error});
}
