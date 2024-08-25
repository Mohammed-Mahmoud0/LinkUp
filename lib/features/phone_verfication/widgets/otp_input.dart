import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';

class OTPInput extends StatelessWidget {
  final int length;
  final double spacing;
  final TextEditingController controller;

  OTPInput({
    required this.length,
    required this.controller,
    this.spacing = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(length, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: TextFormField(
              controller: TextEditingController(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: ColorsManager.offWhite,
              ),
              keyboardType: TextInputType.number,
              autofocus: true,
              maxLength: 1,
              cursorHeight: 20.h,
              cursorColor: ColorsManager.mainBlue,
              decoration: InputDecoration(
                fillColor: ColorsManager.dark,
                filled: true,
                counterText: '',
                contentPadding: const EdgeInsets.all(12.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorsManager.dark,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: ColorsManager.dark,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25.0.r),
                ),
              ),
              onChanged: (value) {
                if (value.length == 1) {
                  // Move to the next field when a digit is entered
                  if (index < length - 1) {
                    FocusScope.of(context).nextFocus();
                  }
                } else if (value.isEmpty) {
                  // Move to the previous field when a digit is deleted
                  if (index > 0) {
                    FocusScope.of(context).previousFocus();
                  }
                }
              },
            ),
          ),
        );
      }),
    );
  }
}
