import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';

class ChatUserWidget extends StatelessWidget {
  final String userName;

  const ChatUserWidget({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
