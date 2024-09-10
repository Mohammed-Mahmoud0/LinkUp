import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/models/message.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/in_chat/ui/widgets/chat_buble.dart';

class InChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;

  InChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
  });

  @override
  State<InChatScreen> createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      Duration(milliseconds: 500),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    focusNode.dispose();
    _messageController.dispose();
  }

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildMessageList(),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 16.0, top: 8.0, bottom: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: ColorsManager.offWhite,
                ),
                horizontalSpace(8),
                Expanded(
                  child: AppTextFormField(
                    focusNode: focusNode,
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
                          widget.receiverId, _messageController.text);
                      _messageController.clear();
                      scrollDown();
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

  Widget _buildMessageList() {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: getMessages(senderId, widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty || !snapshot.hasData) {
          return const Center(child: Text('No messages yet...'));
        }
        //
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   scrollDown();
        // });


        return ListView.builder(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            Message message = Message(
              message: doc['message'],
              senderId: doc['senderId'],
              senderEmail: doc['senderEmail'],
              receiverId: doc['receiverId'],
              timestamp: doc['timestamp'],
            );

            // Determine if the message is sent by the current user
            bool isSender = message.senderId == senderId;

            if (isSender) {
              return ChatBubbleSender(message: message.message);
            } else {
              return ChatBubbleReceiver(message: message.message);
            }
          },
        );
      },
    );
  }

  Future<void> sendMessage(String receiverId, message) async {
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail = FirebaseAuth.instance.currentUser!.email!;
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

    await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
