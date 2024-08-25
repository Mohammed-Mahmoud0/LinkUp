import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_button.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/phone_verfication/widgets/otp_input.dart';

class PhoneVerificationScreen extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();

  PhoneVerificationScreen({super.key});

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
                'Enter Code',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
              verticalSpace(8.h),
              Text(
                'We have sent you an SMS with the code\nto +62 1309 - 1710 - 1920',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
              verticalSpace(64.h),
              OTPInput(
                length: 4, // Assuming the OTP is 4 digits
                controller: otpController,
                spacing: 16.0,
              ),
              verticalSpace(100.h),
              Text(
                'Resend Code',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
