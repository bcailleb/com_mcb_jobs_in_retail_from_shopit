import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:com_mcb_jobs_in_retail_from_shopit/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../layout/screen_layout.dart';
import '../screens/sign_in_screen.dart';
import '../utils/color_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key});
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: kAppName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: backgroundColor1,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
            Locale('fr', ''), // french, no country code
          ],
          home: const Home(),
        );
      },
      maxTabletWidth: 900, // Optional
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> user) {
          if (user.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: buttonColor,
              ),
            );
          } else if (user.hasData) {
            return  ScreenLayout();
          } else {
            return const SignInScreen();
          }
        });
  }
}
