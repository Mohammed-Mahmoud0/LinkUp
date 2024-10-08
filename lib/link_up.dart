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
import 'package:link_up/features/settings/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LinkUp extends StatelessWidget {
  const LinkUp({super.key});

  Future<String> _determineInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasViewedOnboarding = prefs.getBool('hasViewedOnboarding') ?? false;

    if (FirebaseAuth.instance.currentUser != null) {
      return '/home';
    } else if (hasViewedOnboarding) {
      return '/email_login';
    } else {
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
                splashColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                appBarTheme: AppBarTheme(
                  backgroundColor: ColorsManager.backgroundDark,
                  scrolledUnderElevation: 0,
                ),
              ),
              debugShowCheckedModeBanner: false,
              routes: {
                '/onboarding': (context) => const OnboardingScreen(),
                '/email_register': (context) => EmailRegisterScreen(),
                '/email_login': (context) => EmailLoginScreen(),
                '/home': (context) => HomeScreen(),
                '/chats': (context) => const ChatsScreen(),
                '/settings': (context) => const SettingsScreen(),
              },
              initialRoute: snapshot.data ?? '/onboarding',
            );
          }
        },
      ),
    );
  }
}
