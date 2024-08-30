import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(100.h),
              Image.asset('assets/images/Illustration.png'),
              verticalSpace(50.h),
              Text(
                'Connect easily\nwith your family and friends\nover countries',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
              verticalSpace(100.h),
              Text(
                'Terms & Privacy Policy',
                style: TextStyle(
                  color: ColorsManager.offWhite,
                  fontSize: 13.sp,
                ),
              ),
              verticalSpace(16.h),
              AppTextButton(
                buttonText: 'Start Messaging',
                textStyle: TextStyle(
                  color: ColorsManager.offWhite,
                  fontSize: 16.sp,
                ),
                borderRadius: 30.r,
                onPressed: () {
                  Navigator.pushNamed(context, '/email_login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
