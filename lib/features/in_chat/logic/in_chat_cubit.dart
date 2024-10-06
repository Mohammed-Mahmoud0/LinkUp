import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/core/models/message.dart';
import 'package:link_up/features/in_chat/logic/in_chat_states.dart';

class InChatCubit extends Cubit<InChatStates> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();

  static InChatCubit get(context) => BlocProvider.of(context);

  String get currentUserId => _auth.currentUser?.uid ?? '';

  InChatCubit() : super(InChatInitialState());

  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      message: message,
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String otherUserId) {
    String userId = _auth.currentUser!.uid;
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  bool isSender(Message message) {
    return message.senderId == _auth.currentUser!.uid;
  }

  void playSendSound() async {
    await _audioPlayer.play(AssetSource('sounds/send.mp3'));
  }

  void playReceiveSound() async {
    await _audioPlayer.play(AssetSource('sounds/receive.mp3'));
  }

  void scrollDown(scrollController, {isInitialLoad = false}) {
    if (scrollController.hasClients) {
      if (isInitialLoad) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      } else {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuad,
        );
      }
    }
  }

  void showKeyboard() {
    emit(InChatShowKeyboardState());
  }

  void hideKeyboard() {
    emit(InChatHideKeyboardState());
  }
}
