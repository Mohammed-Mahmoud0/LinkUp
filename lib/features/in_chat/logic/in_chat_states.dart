import 'package:link_up/core/models/message.dart';

abstract class InChatStates {}

class InChatInitialState extends InChatStates {}

class InChatLoadingState extends InChatStates {}

class InChatLoadedState extends InChatStates {
  final List<Message> messages;

  InChatLoadedState(this.messages);
}

class InChatErrorState extends InChatStates {
  final String error;
  InChatErrorState(this.error);
}

class InChatMessageSentState extends InChatStates {}
