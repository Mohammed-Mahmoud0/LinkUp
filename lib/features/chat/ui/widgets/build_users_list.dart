import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/features/chat/logic/chats_cubit.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';
import 'package:link_up/features/chat/ui/widgets/chat_user_widget.dart';
import 'package:link_up/features/in_chat/logic/in_chat_cubit.dart';
import 'package:link_up/features/in_chat/ui/in_chat_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

Widget buildUsersList(BuildContext context) {
  final ScrollController _scrollController = ScrollController();

  return BlocBuilder<ChatsCubit, ChatsStates>(
    builder: (context, state) {
      if (state is ChatsLoadingState) {
        // return const CircularProgressIndicator(
        //   backgroundColor: ColorsManager.mainBlue,
        //   color: ColorsManager.dark,
        // );
        return Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Skeletonizer(
                containersColor: ColorsManager.dark,
                enableSwitchAnimation: true,
                child: dummyUserWidget(),
              );
            },
          ),
        );
      } else if (state is ChatsSuccessLoadedState) {
        var filteredUsers = context.read<ChatsCubit>().filteredUsers;

        if (filteredUsers.isEmpty) {
          return Center(
              child: const Text(
            'No users found',
            style: TextStyle(
              color: ColorsManager.neutral,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ));
        }

        return Expanded(
          child: RefreshIndicator(
            color: ColorsManager.mainBlue,
            backgroundColor: ColorsManager.backgroundDark,
            onRefresh: () => context.read<ChatsCubit>().refreshChatUsers(),
            child: Scrollbar(
              interactive: true,
              thickness: 1.5.w,
              controller: _scrollController,
              child: ListView.separated(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  var user = filteredUsers[index];
                  return ChatUserWidget(
                    userName: user['name'],
                    userId: user['uid'],
                    userImage: user['profileImage'],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => InChatCubit(),
                            child: InChatScreen(
                              receiverId: user['uid'],
                              receiverName: user['name'],
                              receiverImage: user['profileImage'],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    color: ColorsManager.dark,
                    indent: 16.w,
                    endIndent: 16.w,
                  );
                },
              ),
            ),
          ),
        );
      } else if (state is ChatsErrorState) {
        return Text('Error: ${state.error}');
      }

      return const SizedBox();
    },
  );
}

Widget dummyUserWidget() {
  return Card(
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: ColorsManager.dark,
          radius: 28.r,
          child: Icon(
            IconBroken.Profile,
            size: 40.sp,
            color: ColorsManager.offWhite,
          ),
        ),
        horizontalSpace(16.w),
        Text(
          'User Name',
        ),
      ],
    ),
  );
}
