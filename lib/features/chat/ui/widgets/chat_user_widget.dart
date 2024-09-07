import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';

class ChatUserWidget extends StatelessWidget {
  final String userName;
  final String userId;
  final VoidCallback onTap;

  const ChatUserWidget({
    super.key,
    required this.userName,
    required this.userId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 64.h,
            width: 64.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              color: ColorsManager.dark,
            ),
            child: Icon(
              IconBroken.Profile,
              size: 40.sp,
            ),
          ),
          horizontalSpace(16.w),
          Text(
            userName,
            style: TextStyle(
              color: ColorsManager.offWhite,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
