import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/features/chat/logic/chats_cubit.dart';
import 'package:link_up/features/chat/ui/widgets/build_search_field.dart';
import 'package:link_up/features/chat/ui/widgets/build_users_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit()..getChatsUsers(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildSearchField(context),
                verticalSpace(16),
                buildUsersList(context),
              ],
            ),
          ),
        );
      }),
    );
  }
}
