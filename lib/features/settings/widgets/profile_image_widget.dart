// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/features/settings/logic/settings_cubit.dart';
import 'package:link_up/features/settings/logic/settings_states.dart';
import 'package:link_up/features/settings/widgets/image_picker_utils.dart';

class ProfileImageWidget extends StatelessWidget {
  ProfileImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsStates>(
      builder: (context, state) {
        final cubit = SettingsCubit.get(context);

        return Stack(
          children: [
            if (state is UpdateProfileImageSuccessState ||
                cubit.userModel?.profileImage != null)
              CircleAvatar(
                backgroundColor: ColorsManager.dark,
                backgroundImage: NetworkImage(cubit.userModel!.profileImage!),
                radius: 64.r,
              )
            else
              CircleAvatar(
                backgroundColor: ColorsManager.dark,
                radius: 64.r,
                child: Icon(
                  IconBroken.Profile,
                  size: 64.sp,
                  color: ColorsManager.offWhite,
                ),
              ),
            Positioned(
              bottom: -5,
              right: -5,
              child: IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () => selectImage(context, (img) {
                  BlocProvider.of<SettingsCubit>(context)
                      .updateProfileImage(img);
                }),
                icon: Icon(
                  Icons.add_circle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
