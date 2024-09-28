import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';

AppBar inChatAppBar(context, receiverName, receiverImage) {
  return AppBar(
    title: Row(
      children: [
        receiverImage != null
            ? CircleAvatar(
                backgroundColor: ColorsManager.dark,
                backgroundImage: NetworkImage(receiverImage!),
                radius: 22.r,
              )
            : CircleAvatar(
                backgroundColor: ColorsManager.dark,
                radius: 22.r,
                child: Icon(
                  IconBroken.Profile,
                  size: 24.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
        horizontalSpace(10),
        Text(
          receiverName,
          style: TextStyle(
            color: ColorsManager.offWhite,
            fontSize: 16.sp,
          ),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(
        Icons.keyboard_arrow_left,
      ),
    ),
    leadingWidth: 32.w,
    titleSpacing: 8.w,
  );
}
