import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/models/message.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/in_chat/ui/widgets/chat_buble.dart';

class InChatScreen extends StatelessWidget {
  final String userId;
  final String userName;
  final TextEditingController _messageController = TextEditingController();
  late final String chatId;

  InChatScreen({
    super.key,
    required this.userId,
    required this.userName,
  }) {
    chatId = createChatId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(userName),
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: ColorsManager.dark,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('chats')
                              .doc(chatId)
                              .collection('messages')
                              .orderBy('timestamp', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final messages = snapshot.data!.docs
                                  .map((doc) => Message(
                                        doc['message'],
                                        doc['senderId'],
                                      ))
                                  .toList();

                              return ListView.builder(
                                itemCount: messages.length,
                                itemBuilder: (context, index) {
                                  final message = messages[index];
                                  if (message.senderId == userId) {
                                    return ChatBubbleSender(message: message);
                                  } else {
                                    return ChatBubbleReceiver(message: message);
                                  }
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 16.0, top: 8.0, bottom: 20.0),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: ColorsManager.offWhite,
                ),
                horizontalSpace(8),
                Expanded(
                  child: AppTextFormField(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: ColorsManager.offWhite,
                    ),
                    controller: _messageController,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                horizontalSpace(16),
                GestureDetector(
                  onTap: () async {
                    if (_messageController.text.isNotEmpty) {
                      await sendMessage(
                          chatId, userId, _messageController.text);
                      print('Message sent: ${_messageController.text}');
                      _messageController.clear();
                    }
                  },
                  child: const Icon(
                    IconBroken.Send,
                    color: ColorsManager.mainBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(
      String chatId, String senderId, String message) async {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'senderId': senderId,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> createChat(String user1Id, String user2Id) async {
    final chatDoc = await FirebaseFirestore.instance
        .collection('chats')
        .where('users', arrayContains: user1Id)
        .where('users', arrayContains: user2Id)
        .get();

    if (chatDoc.docs.isEmpty) {
      // Create a new chat document
      await FirebaseFirestore.instance.collection('chats').add({
        'users': [user1Id, user2Id],
      });
    }
  }


  String createChatId(String otherUserId) {
    // Create a chatId combining userId and otherUserId in a consistent way
    if (userId.compareTo(otherUserId) > 0) {
      return '$userId-$otherUserId';
    } else {
      return '$otherUserId-$userId';
    }
  }

}
