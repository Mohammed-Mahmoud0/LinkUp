import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/helpers/validators.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/style.dart';
import 'package:link_up/core/widgets/app_text_button.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/email_login/logic/login_cubit.dart';
import 'package:link_up/features/email_login/logic/login_states.dart';
import 'package:link_up/features/email_login/ui/widgets/dont_have_account_text.dart';
import 'package:link_up/features/email_login/ui/widgets/terms_and_conditions_text.dart';

class EmailLoginScreen extends StatelessWidget {
  EmailLoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocConsumer<LoginCubit, LoginStates>(
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else if (state is LoginErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: ColorsManager.offWhite,
                            fontSize: 16.0,
                          ),
                        ),
                        backgroundColor: ColorsManager.dark,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final loginCubit = BlocProvider.of<LoginCubit>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyles.font24OffWhiteBold,
                      ),
                      verticalSpace(8),
                      Text(
                        'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                        style: TextStyles.font14grayregular,
                      ),
                      verticalSpace(36),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AppTextFormField(
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                color: ColorsManager.offWhite,
                              ),
                              controller: email,
                              validator: Validators.validateEmail,
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
                            ),
                            verticalSpace(18),
                            AppTextFormField(
                              hintText: 'Password',
                              isObscureText: loginCubit.isObscureText,
                              controller: password,
                              validator: Validators.validatePassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  loginCubit.changeObscureTextStatus();
                                },
                                child: Icon(
                                  loginCubit.isObscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
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
                            ),
                            verticalSpace(24),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                'Forgot Password?',
                                style: TextStyles.font13blueregular,
                              ),
                            ),
                            verticalSpace(40),
                            if (state is LoginLoadingState)
                              const CircularProgressIndicator(
                                backgroundColor: ColorsManager.mainBlue,
                                color: ColorsManager.dark,
                              ),
                            if (state is! LoginLoadingState)
                              AppTextButton(
                                buttonText: 'Login',
                                textStyle: TextStyles.font16whitesemibold,
                                borderRadius: 30.r,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // Proceed with the form submission
                                    BlocProvider.of<LoginCubit>(context)
                                        .loginWithEmailAndPassword(
                                            email.text, password.text);
                                  }
                                },
                              ),
                            verticalSpace(16),
                            const TermsAndConditionsText(),
                            verticalSpace(60),
                            const DontHaveAccountText(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
