import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/features/chat/logic/chats_cubit.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';
import 'package:link_up/features/chat/ui/widgets/chat_user_widget.dart';
import 'package:link_up/features/in_chat/ui/in_chat_screen.dart';

Widget buildUsersList(BuildContext context) {
    return BlocBuilder<ChatsCubit, ChatsStates>(
      builder: (context, state) {
        if (state is ChatsLoadingState) {
          return const CircularProgressIndicator(
            backgroundColor: ColorsManager.mainBlue,
            color: ColorsManager.dark,
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
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  var user = filteredUsers[index];
                  return Column(
                    children: [
                      ChatUserWidget(
                        userName: user['name'],
                        userId: user['uid'],
                        userImage: user['profileImage'],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InChatScreen(
                                receiverId: user['uid'],
                                receiverName: user['name'],
                                receiverImage: user['profileImage'],
                              ),
                            ),
                          );
                        },
                      ),
                      verticalSpace(16),
                    ],
                  );
                },
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