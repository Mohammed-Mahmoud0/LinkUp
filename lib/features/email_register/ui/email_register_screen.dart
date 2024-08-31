import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/validators.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/style.dart';
import 'package:link_up/core/widgets/app_text_button.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/email_login/ui/widgets/terms_and_conditions_text.dart';
import 'package:link_up/features/email_register/logic/register_cubit.dart';
import 'package:link_up/features/email_register/logic/register_states.dart';
import 'package:link_up/features/email_register/ui/widgets/already_have_account.dart';

class EmailRegisterScreen extends StatelessWidget {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  final formKey = GlobalKey<FormState>();

  EmailRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocConsumer<RegisterCubit, RegisterStates>(
                listener: (context, state) {
                  if (state is RegisterSuccessState) {
                    Navigator.pop(context);
                  } else if (state is RegisterErrorState) {
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
                  final registerCubit = BlocProvider.of<RegisterCubit>(context);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyles.font24OffWhiteBold,
                      ),
                      verticalSpace(8),
                      Text(
                        'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
                        style: TextStyles.font14GrayRegular,
                      ),
                      verticalSpace(36),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            AppTextFormField(
                              hintText: 'Name',
                              controller: name,
                              validator: Validators.validateName,
                            ),
                            verticalSpace(18),
                            AppTextFormField(
                              hintText: 'Phone number',
                              controller: phone,
                              validator: Validators.validatePhone,
                            ),
                            verticalSpace(18),
                            AppTextFormField(
                              hintText: 'Email',
                              controller: email,
                              validator: Validators.validateEmail,
                            ),
                            verticalSpace(18),
                            AppTextFormField(
                              hintText: 'Password',
                              controller: password,
                              validator: Validators.validatePassword,
                              isObscureText: registerCubit.isObscureText,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  registerCubit.changeObscureTextStatus();
                                },
                                child: Icon(
                                  registerCubit.isObscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
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
                            if (state is RegisterLoadingState)
                              const CircularProgressIndicator(
                                backgroundColor: ColorsManager.mainBlue,
                                color: ColorsManager.dark,
                              ),
                            if (state is! RegisterLoadingState)
                              AppTextButton(
                                buttonText: 'Create Account',
                                textStyle: TextStyles.font16whitesemibold,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    registerCubit.registerWithEmailAndPassword(
                                        email.text, password.text);
                                  }
                                },
                              ),
                            verticalSpace(16),
                            const TermsAndConditionsText(),
                            verticalSpace(60),
                            const AlreadyHaveAccountText(),
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
