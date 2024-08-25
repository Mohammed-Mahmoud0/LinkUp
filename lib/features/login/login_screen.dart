import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_button.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              verticalSpace(64.h),
              Text(
                'Enter Your Phone Number',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
              verticalSpace(8.h),
              Text(
                'Please confirm your country code and enter\nyour phone number',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
              verticalSpace(50.h),
              Row(
                children: [
                  Container(
                    height: 44.h,
                    width: 70.w,
                    decoration: BoxDecoration(
                      color: ColorsManager.dark,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/Flag.png',
                          height: 16.h,
                        ),
                        horizontalSpace(8.w),
                        Text(
                          '+20',
                          style: TextStyle(
                            color: ColorsManager.offWhite,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(8.w),
                  Expanded(
                    child: AppTextFormField(
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
                      hintText: 'Phone Number',
                      hintStyle: const TextStyle(
                        color: ColorsManager.offWhite,
                      ),
                      keyboardType: TextInputType.number,
                      autoFocus: true,
                    ),
                  ),
                ],
              ),
              verticalSpace(100.h),
              AppTextButton(
                buttonText: 'Continue',
                textStyle: TextStyle(
                  color: ColorsManager.offWhite,
                  fontSize: 16.sp,
                ),
                borderRadius: 30.r,
                onPressed: () {
                  Navigator.pushNamed(context, '/phone_verification');
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}
