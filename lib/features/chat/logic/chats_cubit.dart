import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());

  List<Map<String, dynamic>> users = [];

  void getChats() async {
    try {
      emit(ChatsLoadingState());

      var snapshot = await FirebaseFirestore.instance.collection('users').get();

      users = snapshot.docs.map((doc) => doc.data()).toList();

      for (int i = 0; i < users.length; i++) {
        if (users[i]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
          users.removeAt(i);
        }
      }

      emit(ChatsSuccessLoadedState());
    } catch (e) {
      emit(ChatsErrorState(error: e.toString()));
    }
  }
}