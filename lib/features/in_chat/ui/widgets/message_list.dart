import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/models/message.dart';
import 'package:link_up/features/in_chat/logic/in_chat_cubit.dart';
import 'package:link_up/features/in_chat/ui/widgets/chat_bubble.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget MessageList(receiverId, scrollController, context) {
  bool isInitialLoad = true;
  // ignore: unused_local_variable
  bool lastMessageIsReceived = false;
  var cubit = InChatCubit.get(context);
  return StreamBuilder(
    stream: cubit.getMessages(receiverId),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      if (snapshot.connectionState == ConnectionState.waiting) {
        // return const Center(
        //   child: CircularProgressIndicator(
        //     backgroundColor: ColorsManager.mainBlue,
        //     color: ColorsManager.dark,
        //   ),
        // );

        return ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return Skeletonizer(
              // containersColor: ColorsManager.backgroundDark,
              enableSwitchAnimation: true,
              child: Column(
                children: [
                  ChatBubbleSender(
                    message: 'Loading ...',
                  ),
                  verticalSpace(20.h),
                  ChatBubbleReceiver(
                    message: 'Loading ...',
                  ),
                  verticalSpace(20.h),
                ],
              ),
            );
          },
        );
      }

      if (snapshot.data!.docs.isEmpty || !snapshot.hasData) {
        return const Center(child: Text('Start Messaging now ...'));
      }

      DocumentSnapshot lastDoc = snapshot.data!.docs.last;
      Message lastMessage =
          Message.fromMap(lastDoc.data() as Map<String, dynamic>);
      bool isSender = cubit.isSender(lastMessage);

      if (!isInitialLoad && !isSender) {
        cubit.playReceiveSound();
      }

      lastMessageIsReceived = !isSender;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        cubit.scrollDown(scrollController, isInitialLoad: isInitialLoad);
        isInitialLoad = false;
      });

      return Scrollbar(
        interactive: true,
        thickness: 1.5.w,
        controller: scrollController,
        child: ListView.builder(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot doc = snapshot.data!.docs[index];
            Message message =
                Message.fromMap(doc.data() as Map<String, dynamic>);

            bool isSender = cubit.isSender(message);

            if (isSender) {
              return ChatBubbleSender(message: message.message);
            } else {
              return ChatBubbleReceiver(message: message.message);
            }
          },
        ),
      );
    },
  );
}
