import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/chat/logic/chats_cubit.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';
import 'package:link_up/features/in_chat/ui/in_chat_screen.dart';
import 'package:link_up/features/chat/ui/widgets/chat_user_widget.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..getChats(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar
              AppTextFormField(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: ColorsManager.neutral,
                  fontSize: 16.sp,
                ),
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.search,
                  color: ColorsManager.neutral,
                  size: 24,
                ),
              ),
              verticalSpace(16.h),
              BlocBuilder<ChatsCubit, ChatsStates>(
                builder: (context, state) {
                  if (state is ChatsLoadingState) {
                    return Center(
                      child: const CircularProgressIndicator(
                        backgroundColor: ColorsManager.mainBlue,
                        color: ColorsManager.dark,
                      ),
                    );
                  } else if (state is ChatsSuccessLoadedState) {
                    var users = context.read<ChatsCubit>().users;

                    if (users.isEmpty) {
                      return const Text('No users found');
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          var user = users[index];
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
                                      ),
                                    ),
                                  );
                                },
                              ),
                              verticalSpace(16.h),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (state is ChatsErrorState) {
                    return Text('Error: ${state.error}');
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
