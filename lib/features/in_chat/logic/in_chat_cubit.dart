import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/core/models/message.dart';
import 'package:link_up/features/in_chat/logic/in_chat_states.dart';

class InChatCubit extends Cubit<InChatStates> {
  InChatCubit() : super(InChatInitialState());



}
