import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/helpers/spacing.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/core/theming/icon_broken.dart';
import 'package:link_up/core/widgets/app_text_form_field.dart';
import 'package:link_up/features/chat/ui/chats_screen.dart';
import 'package:link_up/features/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ChatsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            _selectedIndex == 0 ? 'Chats' : 'Settings',
            style: TextStyle(
              color: ColorsManager.offWhite,
              fontSize: 24.sp,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: navigationBar(context),
    );
  }

  Theme navigationBar(BuildContext context) {
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
              color: ColorsManager.dark,
              blurRadius: 10.0,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0.r),
            topRight: Radius.circular(16.0.r),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Chat,
                color: _selectedIndex == 0
                    ? ColorsManager.offWhite
                    : ColorsManager.neutral,
                size: _selectedIndex == 0 ? 24.sp : 22.sp,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconBroken.Setting,
                color: _selectedIndex == 1
                    ? ColorsManager.offWhite
                    : ColorsManager.neutral,
                size: _selectedIndex == 0 ? 24.sp : 22.sp,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: _selectedIndex,
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
          onTap: _onItemTapped,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
