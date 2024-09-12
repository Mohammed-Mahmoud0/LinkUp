import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/show_snack_bar.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/widgets/app_text_button.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/settings/logic/settings_cubit.dart';
import 'package:link_up/features/settings/logic/settings_states.dart';
import 'package:link_up/features/settings/widgets/profile_image_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    return BlocProvider(
      create: (context) => SettingsCubit()..getUserData(),
      child: BlocListener<SettingsCubit, SettingsStates>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccessState) {
            showSnackBar(context, state.message);
          } else if (state is UpdateUserDataErrorState) {
            showSnackBar(context, state.error);
          }
        },
        child: BlocBuilder<SettingsCubit, SettingsStates>(
          builder: (context, state) {
            var cubit = SettingsCubit.get(context);

            if (state is GetUserDataSuccessState) {
              nameController.text = cubit.userModel?.name ?? '';
              phoneController.text = cubit.userModel?.phone ?? '';
              emailController.text = cubit.userModel?.email ?? '';
            }

            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(50.h),
                      const ProfileImageWidget(image: 'https://www.pngitem.com/pimgs/m/421-4212266_transparent-default-avatar-png-default-avatar-images-png.png',),
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
                        hintText: 'Name',
                        hintStyle: const TextStyle(
                          color: ColorsManager.offWhite,
                        ),
                        keyboardType: TextInputType.text,
                        controller: nameController,
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
                        hintText: 'Phone Number',
                        hintStyle: const TextStyle(
                          color: ColorsManager.offWhite,
                        ),
                        keyboardType: TextInputType.text,
                        controller: phoneController,
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
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: ColorsManager.offWhite,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        readOnly: true,
                      ),
                      verticalSpace(64.h),
                      if (state is SettingsLoadingState)
                        const CircularProgressIndicator(
                          backgroundColor: ColorsManager.mainBlue,
                          color: ColorsManager.dark,
                        ),
                      if (state is! SettingsLoadingState)
                        AppTextButton(
                          buttonText: 'Save',
                          textStyle: TextStyle(
                            color: ColorsManager.offWhite,
                            fontSize: 16.sp,
                          ),
                          borderRadius: 30.r,
                          onPressed: () {
                            cubit.updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                          },
                        ),
                      verticalSpace(24.h),
                      AppTextButton(
                        buttonText: 'Logout',
                        backgroundColor: Colors.red.shade800,
                        textStyle: TextStyle(
                          color: ColorsManager.offWhite,
                          fontSize: 16.sp,
                        ),
                        borderRadius: 30.r,
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(context, '/email_login');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

