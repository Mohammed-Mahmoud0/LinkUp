import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({
    super.key,
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
          child: Image.asset(
            'assets/images/person.png',
          ),
        ),
        const Positioned(
          bottom: 5,
          right: 5,
          child: Icon(
            Icons.add_circle,
          ),
        ),
      ],
    );
  }
}
