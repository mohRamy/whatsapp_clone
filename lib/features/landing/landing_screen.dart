import "package:flutter/material.dart";
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/component/components.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import '../../common/utils/app_colors.dart';
import '../../common/widgets/custom_button.dart';
import '../auth/screens/login_screen.dart';
import '../../routes.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90, bottom: 110),
                child: Image.asset(
                  AppString.assetsInit,
                  color: AppColors.tabColor,
                  height: 340,
                ),
              ),
              const Text(
                'Read our privacy Policy. To"Agree and continue"to\naccept Terms of Service.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
              SizedBox(
                height: context.height20 + 5,
              ),
              CustomButton(
                onPressed: () {
                  Components.navigateAndFinish(context, Routes.loginScreen, {});
                },
                txt: 'AGREE AND CONTINUE',
                size: const Size(300, 50),
                txtColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
