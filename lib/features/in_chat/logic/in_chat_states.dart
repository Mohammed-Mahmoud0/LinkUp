import 'package:link_up/core/models/message.dart';

class InChatStates {}

class InChatInitialState extends InChatStates {}

class InChatLoadingState extends InChatStates {}

class InChatLoadedState extends InChatStates {
  final List<Message> messages;

  InChatLoadedState(this.messages);
}

class InChatErrorState extends InChatStates {
  final String errorMessage;

  InChatErrorState(this.errorMessage);
}

class InChatNewMessageSentState extends InChatStates {}

class InChatShowKeyboardState extends InChatStates {}

class InChatHideKeyboardState extends InChatStates {}