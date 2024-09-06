import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';

class ChatsCubit extends Cubit<ChatsStates> {
  ChatsCubit() : super(ChatsInitialState());

  List<Map<String, dynamic>> users = [];

  // Function to get users from Firestore
  void getChats() async {
    try {
      emit(ChatsLoadingState());

      // Fetch users from Firestore
      var snapshot = await FirebaseFirestore.instance.collection('users').get();

      users = snapshot.docs.map((doc) => doc.data()).toList();

      emit(ChatsSuccessLoadedState());
    } catch (e) {
      emit(ChatsErrorState(error: e.toString()));
    }
  }
}