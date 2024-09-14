import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/features/home/logic/home_cubit.dart';

class NavigationBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.backgroundDark.withOpacity(0.8),
          boxShadow: const [
            BoxShadow(
              blurRadius: 1.0,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r),
          ),
        ),
        child: BlocBuilder<HomeCubit, int>(
          builder: (context, selectedIndex) {
            return BottomNavigationBar(
              backgroundColor: Colors.transparent,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Chat,
                    color: selectedIndex == 0
                        ? ColorsManager.offWhite
                        : ColorsManager.neutral,
                    size: selectedIndex == 0 ? 24.sp : 22.sp,
                  ),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Setting,
                    color: selectedIndex == 1
                        ? ColorsManager.offWhite
                        : ColorsManager.neutral,
                    size: selectedIndex == 1 ? 24.sp : 22.sp,
                  ),
                  label: 'Settings',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: ColorsManager.offWhite,
              unselectedItemColor: ColorsManager.neutral,
              selectedLabelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.offWhite,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 10.sp,
                color: ColorsManager.neutral,
              ),
              onTap: (index) {
                context.read<HomeCubit>().changeTab(index);
              },
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
            );
          },
        ),
      ),
    );
  }
}
