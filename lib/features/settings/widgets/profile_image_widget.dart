import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? image;

  const ProfileImageWidget({
    super.key,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: ColorsManager.dark,
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                    height: 100.h,
                    width: 100.w,
                  ),
                )
              : Icon(
                  IconBroken.Profile,
                  size: 56.sp,
                ),
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add_circle,
            ),
          ),
        ),
      ],
    );
  }
}
