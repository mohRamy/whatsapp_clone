import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/widgets/error.dart';
import 'package:whatsapp_getx/features/group/screens/create_group_screen.dart';
import 'package:whatsapp_getx/features/status/screens/confirm_status_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/otp_screen.dart';
import 'features/auth/screens/user_information_screen.dart';
import 'features/chat/screens/chat_screen.dart';
import 'models/status_model.dart';
import 'features/select_contacts/screen/select_contacts_screen.dart';
import 'features/status/screens/status_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginScreen = '/loginscreen';
  static const String otpScreen = '/otpscreen';
  static const String userInformationScreen = '/userinformaionscreen';
  static const String homeScreen = '/homerscreen';
  static const String selectContactScreen = '/selectcontactscreen';
  static const String chatScreen = '/chatscreen';
  static const String videoItem = '/videoitem';
  static const String createGroupScreen = '/creategroupscreen';
  static const String confirmStatusScreen = '/confirmstatusscreen';
  static const String statusScreen = '/statusscreen';
}

class AppRoutes {
  static Route? onGenerateroute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.otpScreen:
        final argument = routeSettings.arguments as Map<String, dynamic>;
        final verificationId = argument[AppString.argumentVerificationId];
        final phoneNumber = argument[AppString.argumentPhoneNumber];

        return MaterialPageRoute(
          builder: (context) => OTPscreen(
            verificationId: verificationId,
            phoneNumber: phoneNumber,
          ),
        );
      case Routes.userInformationScreen:
        return MaterialPageRoute(
          builder: (context) => const UserInformationScreen(),
        );
      case Routes.selectContactScreen:
        return MaterialPageRoute(
          builder: (context) => const SelectContacts(),
        );
      case Routes.chatScreen:
        final arguments = routeSettings.arguments as Map<String, dynamic>;
        final name = arguments[AppString.argumentName];
        final uid = arguments[AppString.argumentUid];
        final isGroupChat = arguments[AppString.argumentisGroupChat];
        final profilePic = arguments[AppString.argumentImage];
        return MaterialPageRoute(
          builder: (context) => ChatScreen(
            name: name,
            uid: uid,
            isGroupChat: isGroupChat,
            profilePic: profilePic,
          ),
        );
      case Routes.confirmStatusScreen:
        final file = routeSettings.arguments as File;
        return MaterialPageRoute(
          builder: (context) => ConfirmStatusScreen(
            file: file,
          ),
        );
      case Routes.statusScreen:
        final status = routeSettings.arguments as Status;
        return MaterialPageRoute(
          builder: (context) => StatusScreen(
            status: status,
          ),
        );
      case Routes.createGroupScreen:
        return MaterialPageRoute(
          builder: (context) => const CreateGroupScreen(),
        );
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(
            AppString.pageNotExsit,
          ),
        ),
      ),
    );
  }
}
