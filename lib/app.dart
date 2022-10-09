import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_colors.dart';
import 'package:whatsapp_getx/features/home/screen/home_screen.dart';
import 'package:whatsapp_getx/routes.dart';
import 'common/widgets/error.dart';
import 'common/widgets/loader.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/landing/landing_screen.dart';

class WhatsApp extends ConsumerWidget {
  const WhatsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor:AppColors.backgroundColor,
        appBarTheme: AppBarTheme(
          color: AppColors.appBarColor,
        ),
      ),
      onGenerateRoute: (settings) =>AppRoutes.onGenerateroute(settings),
      home: ref.watch(userDataAuthProvider).when( 
            data: (user) {
              if (user == null) {
                return const LandingScreen();
              }
              return const HomeScreen();
            },
            error: (err, trace) {
              return ErrorScreen(
                error: err.toString(),
              );
            },
            loading: () => const Loader(),
          ),
    );
  }
}
