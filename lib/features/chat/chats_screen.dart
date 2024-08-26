import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/chat/widgets/chat_user_widget.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppTextFormField(
              backgroundColor: ColorsManager.dark,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
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
            const ChatUserWidget(),
            verticalSpace(16.h),
            const ChatUserWidget(),
            verticalSpace(16.h),
            const ChatUserWidget(),
          ],
        ),
      ),
    );
  }
}