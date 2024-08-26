import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_button.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/settings/widgets/profile_image_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(50.h),
            const ProfileImageWidget(),
            verticalSpace(24.h),
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
              hintText: 'First Name',
              hintStyle: const TextStyle(
                color: ColorsManager.offWhite,
              ),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(10.h),
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
              hintText: 'Last Name',
              hintStyle: const TextStyle(
                color: ColorsManager.offWhite,
              ),
              keyboardType: TextInputType.text,
            ),
            verticalSpace(64.h),
            AppTextButton(
              buttonText: 'Save',
              textStyle: TextStyle(
                color: ColorsManager.offWhite,
                fontSize: 16.sp,
              ),
              borderRadius: 30.r,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
