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

class InChatScreen extends StatelessWidget {
  final String receiverId;
  final String receiverName;
  final String? receiverImage;

  final TextEditingController _messageController = TextEditingController();

  final AudioPlayer audioPlayer = AudioPlayer();

  final ScrollController scrollController = ScrollController();

  InChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    this.receiverImage,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = InChatCubit.get(context);

    return Scaffold(
      appBar: inChatAppBar(context, receiverName, receiverImage),
      body: Column(
        children: [
          Expanded(
            child: Container(
                color: ColorsManager.dark,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageList(receiverId, scrollController, context),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: ColorsManager.mainBlue,
                    size: 24.sp,
                  ),
                ),
                Expanded(
                  child: AppTextFormField(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: ColorsManager.offWhite,
                      fontSize: 13.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25.r,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        25.r,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    inputTextStyle: TextStyle(
                      color: ColorsManager.offWhite,
                      fontSize: 16.sp,
                    ),
                    controller: _messageController,
                  ),
                ),
                horizontalSpace(8),
                ValueListenableBuilder(
                  valueListenable: _messageController,
                  builder: (context, TextEditingValue value, __) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: value.text.isNotEmpty
                          ? BlocBuilder<InChatCubit, InChatStates>(
                              builder: (context, state) {
                                return Container(
                                  key: ValueKey('sendButton'),
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: ColorsManager.dark,
                                  ),
                                  child: IconButton(
                                    onPressed: () async {
                                      if (_messageController.text.isNotEmpty) {
                                        await cubit.sendMessage(receiverId,
                                            _messageController.text);
                                        _messageController.clear();
                                        cubit.scrollDown(scrollController);
                                        cubit.playSendSound();
                                      }
                                    },
                                    icon: Icon(IconBroken.Send),
                                    color: ColorsManager.mainBlue,
                                  ),
                                );
                              },
                            )
                          : SizedBox(
                              key: ValueKey('emptyWidget'),
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
