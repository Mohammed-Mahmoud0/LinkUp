abstract class InChatStates {}

class InChatInitialState extends InChatStates {}

class InChatLoadingState extends InChatStates {}

class InChatLoadedState extends InChatStates {}

class InChatErrorState extends InChatStates {
  final String error;
  InChatErrorState(this.error);
}

class InChatMessageSentState extends InChatStates {}
