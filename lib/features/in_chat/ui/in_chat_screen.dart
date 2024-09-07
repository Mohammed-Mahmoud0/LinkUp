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

  InChatScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

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
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ChatBubbleSender(
                            message: Message('Hello, how are you?', '1')),
                        ChatBubbleReceiver(message: Message('iam good', '2')),
                        ChatBubbleSender(
                            message: Message('Hello, how are you?', '1')),
                      ],
                    ),
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
                  onTap: () {
                    if (_messageController.text.isNotEmpty) {
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
}
