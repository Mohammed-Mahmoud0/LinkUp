import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';

class OTPInput extends StatefulWidget {
  final int length;
  final double spacing;
  final TextEditingController controller;
  final void Function(String otp)? onSubmit;

  const OTPInput({
    super.key,
    required this.length,
    required this.controller,
    this.spacing = 8.0,
    this.onSubmit,
  });

  @override
  _OTPInputState createState() => _OTPInputState();
}

class _OTPInputState extends State<OTPInput> {
  List<String> _otpValues = [];

  @override
  void initState() {
    super.initState();
    _otpValues = List<String>.filled(widget.length, '');
  }

  void _onFieldChanged(int index, String value) {
    setState(() {
      _otpValues[index] = value;
    });

    // Move to the next field if a digit is entered
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).nextFocus();
    }

    // Move to the previous field if cleared
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).previousFocus();
    }

    // Check if the OTP is complete
    if (_otpValues.join().length == widget.length) {
      widget.onSubmit?.call(_otpValues.join());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.spacing),
          child: SizedBox(
            width: 50.w,
            height: 50.h,
            child: TextFormField(
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: ColorsManager.offWhite,
              ),
              keyboardType: TextInputType.number,
              autofocus: index == 0,
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
              onChanged: (value) => _onFieldChanged(index, value),
            ),
          ),
        );
      }),
    );
  }
}
