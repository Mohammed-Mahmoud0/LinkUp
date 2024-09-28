import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/in_chat/logic/in_chat_cubit.dart';
import 'package:link_up/features/in_chat/logic/in_chat_states.dart';
import 'package:link_up/features/in_chat/ui/widgets/in_chat_app_bar.dart';
import 'package:link_up/features/in_chat/ui/widgets/message_list.dart';

class InChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String? receiverImage;

  InChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    this.receiverImage,
  });

  @override
  State<InChatScreen> createState() => _InChatScreenState();
}

class _InChatScreenState extends State<InChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final AudioPlayer audioPlayer = AudioPlayer();
  FocusNode focusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollDown();
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void scrollDown() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(
        scrollController.position.maxScrollExtent,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = InChatCubit.get(context);
    return Scaffold(
      appBar: inChatAppBar(context, widget.receiverName, widget.receiverImage),
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: ColorsManager.dark,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageList(widget.receiverId, scrollController),
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
                      fontSize: 13.sp,
                    ),
                    inputTextStyle: TextStyle(
                      color: ColorsManager.offWhite,
                      fontSize: 16.sp,
                    ),
                    controller: _messageController,
                  ),
                ),
                horizontalSpace(8),
                BlocBuilder<InChatCubit, InChatStates>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        if (_messageController.text.isNotEmpty) {
                          await cubit.sendMessage(
                              widget.receiverId, _messageController.text);
                          _messageController.clear();
                          cubit.scrollDown(scrollController);
                          cubit.playSendSound();
                        }
                      },
                      child: Container(
                        height: 40.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorsManager.dark,
                        ),
                        child: const Icon(
                          IconBroken.Send,
                          color: ColorsManager.mainBlue,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
