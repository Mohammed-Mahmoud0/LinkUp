import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';

class ChatUserWidget extends StatelessWidget {
  const ChatUserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 64.h,
          width: 64.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Image.asset(
            'assets/images/man.png',
          ),
        ),
        horizontalSpace(16.w),
        Text(
          'Mohamed Mahmoud',
          style: TextStyle(
            color: ColorsManager.offWhite,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}