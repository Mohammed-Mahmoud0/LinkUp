import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/features/chat/chats_screen.dart';
import 'package:link_up/features/home/home_screen.dart';
import 'package:link_up/features/login/login_screen.dart';
import 'package:link_up/features/onboarding/onboarding_screen.dart';
import 'package:link_up/features/phone_verfication/phone_verfication_screen.dart';
import 'package:link_up/features/profile/profile_screen.dart';
import 'package:link_up/features/settings/settings_screen.dart';

class LinkUp extends StatelessWidget {
  const LinkUp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        title: 'LinkUp',
        theme: ThemeData(

          brightness: Brightness.dark,
          scaffoldBackgroundColor: ColorsManager.backgroundDark,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/login': (context) => const LoginScreen(),
          '/phone_verification': (context) => PhoneVerificationScreen(),
          '/profile':(context) => const ProfileScreen(),
          '/chats': (context) => const ChatsScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/home': (context) => const HomeScreen(),
        },
        initialRoute: '/onboarding',
      ),
    );
  }
}
