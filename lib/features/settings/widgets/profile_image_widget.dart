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
            if (cubit.userModel?.profileImage != null)
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
                highlightColor: ColorsManager.backgroundDark.withOpacity(0.8),
                onPressed: () {
                  selectImage(
                    context,
                    (img) {
                      cubit.updateProfileImage(img);
                    },
                  );
                },
                icon: Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: ColorsManager.backgroundDark.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    IconBroken.Edit_Square,
                    color: ColorsManager.offWhite,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
