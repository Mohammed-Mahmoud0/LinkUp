import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());

  List<Map<String, dynamic>> users = [];

  Future<void> _getChatUsers({bool showLoading = true}) async {
    try {
      if (showLoading) {
        emit(ChatsLoadingState());
      }

      var snapshot = await FirebaseFirestore.instance.collection('users').get();

      users = snapshot.docs.map((doc) => doc.data()).toList();

      users.removeWhere(
          (user) => user['uid'] == FirebaseAuth.instance.currentUser!.uid);

      emit(ChatsSuccessLoadedState());
    } catch (e) {
      emit(ChatsErrorState(error: e.toString()));
    }
  }

  void getChatsUsers() async {
    await _getChatUsers(showLoading: true);
  }

  Future<void> refreshChatUsers() async {
    await _getChatUsers(showLoading: false);
  }
}
