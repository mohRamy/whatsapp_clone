import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';

import '../../../common/utils/app_colors.dart';
import '../controller/auth_controller.dart';

class OTPscreen extends ConsumerStatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OTPscreen({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  ConsumerState<OTPscreen> createState() => _OtpscreenState();
}

class _OtpscreenState extends ConsumerState<OTPscreen> {
  TextEditingController otpC = TextEditingController();

  @override
  void dispose() {
    otpC.dispose();
    super.dispose();
  }

  void verifyOtp(String userOtp) {
    ref.read(authControllerProvider).verifyOTP(
          context,
          widget.verificationId,
          userOtp,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppString.verifyPhoneNumber,
          style: TextStyle(
            color: AppColors.tabColor,
          ),
        ),
        actions: [
          PopupMenuButton(
            color: AppColors.senderMessageColor,
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) =>
                [const PopupMenuItem(child: Text(AppString.help))],
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(
                  context.height20,
                  context.height20,
                  context.height20,
                  context.height10,
                ),
                child: Column(
                  children: [
                    const Text(
                      AppString.waiting,
                      style: TextStyle(color: Colors.white60),
                    ),
                     SizedBox(
                      height: context.height10 - 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.phoneNumber}. ',
                        ),
                        InkWell(
                            onTap: () {},
                            child: const Text(
                              AppString.wrongNumber,
                              style: TextStyle(color: Colors.blue),
                            )),
                      ],
                    )
                  ],
                )),
            SizedBox(
              width: 140,
              child: TextField(
                controller: otpC,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOtp(val.trim());
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tabColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tabColor)),
                  hintText: AppString.otpHint,
                  hintStyle:  TextStyle(
                    fontSize: context.font20,
                  ),
                ),
              ),
            ),
             SizedBox(
              height: context.height15,
            ),
            const Text(
              AppString.sexDigit,
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }
}
