import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/chat/logic/chats_cubit.dart';
import 'package:link_up/features/chat/logic/chats_states.dart';

Widget buildSearchField(BuildContext context) {
  return BlocBuilder<ChatsCubit, ChatsStates>(
    builder: (context, state) {
      return AppTextFormField(
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
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        onChanged: (query) {
          context.read<ChatsCubit>().searchUsers(query);
        },
      );
    },
  );
}
