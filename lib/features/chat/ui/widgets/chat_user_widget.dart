import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';

class ChatUserWidget extends StatelessWidget {
  final String userName;
  final String userId;
  final VoidCallback onTap;
  final String? userImage;

  const ChatUserWidget({
    super.key,
    required this.userName,
    required this.userId,
    required this.onTap,
    this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: Row(
        children: [
          userImage != null
              ? CircleAvatar(
                  backgroundColor: ColorsManager.dark,
                  backgroundImage: NetworkImage(userImage!),
                  radius: 28.r,
                )
              : CircleAvatar(
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
