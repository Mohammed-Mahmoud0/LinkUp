import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/features/chat/ui/chats_screen.dart';
import 'package:link_up/features/home/logic/home_cubit.dart';
import 'package:link_up/features/home/ui/widgets/navigation_bar_widget.dart';
import 'package:link_up/features/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> _screens = const [
    ChatsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<HomeCubit, int>(
            builder: (context, selectedIndex) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  selectedIndex == 0 ? 'Chats' : 'Settings',
                  style: TextStyle(
                    color: ColorsManager.offWhite,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<HomeCubit, int>(
          builder: (context, selectedIndex) {
            return IndexedStack(
              index: selectedIndex,
              children: _screens,
            );
          },
        ),
        bottomNavigationBar: NavigationBarWidget(),
      ),
    );
  }
}
