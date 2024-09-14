import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:link_up/core/theming/colors.dart';
import 'package:link_up/features/chat/ui/chats_screen.dart';
import 'package:link_up/features/email_login/ui/email_login_screen.dart';
import 'package:link_up/features/email_register/ui/email_register_screen.dart';
import 'package:link_up/features/home/ui/home_screen.dart';
import 'package:link_up/features/onboarding/onboarding_screen.dart';
import 'package:link_up/features/phone_login/phone_login_screen.dart';
import 'package:link_up/features/phone_verfication/phone_verfication_screen.dart';
import 'package:link_up/features/profile/profile_screen.dart';
import 'package:link_up/features/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LinkUp extends StatelessWidget {
  const LinkUp({super.key});

  Future<String> _determineInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasViewedOnboarding = prefs.getBool('hasViewedOnboarding') ?? false;

    if (FirebaseAuth.instance.currentUser != null) {
      // User is logged in
      return '/home';
    } else if (hasViewedOnboarding) {
      // User is not logged in but has viewed onboarding
      return '/email_login';
    } else {
      // User is not logged in and has not viewed onboarding
      await prefs.setBool('hasViewedOnboarding', true);
      return '/onboarding';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: FutureBuilder<String>(
        future: _determineInitialRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading screen while determining the initial route
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return MaterialApp(
              title: 'LinkUp',
              theme: ThemeData(
                brightness: Brightness.dark,
                scaffoldBackgroundColor: ColorsManager.backgroundDark,
              ),
              debugShowCheckedModeBanner: false,
              routes: {
                '/onboarding': (context) => const OnboardingScreen(),
                '/email_login': (context) => EmailLoginScreen(),
                '/email_register': (context) => EmailRegisterScreen(),
                '/phone_login': (context) => PhoneLoginScreen(),
                '/phone_verification': (context) => PhoneVerificationScreen(),
                '/profile': (context) => const ProfileScreen(),
                '/chats': (context) => const ChatsScreen(),
                '/settings': (context) => const SettingsScreen(),
                '/home': (context) => HomeScreen(),
              },
              initialRoute: snapshot.data ?? '/onboarding',
            );
          }
        },
      ),
    );
  }
}
