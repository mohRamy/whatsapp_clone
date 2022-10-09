import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/custom_button.dart';
import '../controller/auth_controller.dart';
import '../../../common/widgets/custom_snackbar.dart';


class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController phoneC = TextEditingController();
  
  Country? country;

  @override
  void dispose() {
    phoneC.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(

        inputDecoration: InputDecoration(
          
          enabledBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tabColor)),
                        focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tabColor)),
        ),
        bottomSheetHeight: MediaQuery.of(context).size.height,
      ),
      onSelect: (Country _country) {
        setState(() {
          country = _country;
        });
      },
    );
  }

  void verifyPhoneNumber() {
    if (phoneC.text.isNotEmpty) {
      final phoneNumber = '+${country!.phoneCode}${phoneC.text.trim()}';
      ref.read(authControllerProvider).verifyPhoneNumber(
            context,
            phoneNumber,
          );
    } else {
      showSnackBar(
        context: context,
        color: Colors.red,
        content: 'wrong',
      );
    }
  }

  

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title:  Text(
          AppString.verifyPhoneNumber,
          style: TextStyle(
            color: AppColors.tabColor,
            fontSize: context.font20,
            fontWeight: FontWeight.w500,
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
             SizedBox(height: context.height20),
            const Text(
              AppString.whatsappNeed,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
             SizedBox(height: context.height10),
            SizedBox(
              width: 250,
              child: TextField(
                onTap: pickCountry,
                readOnly: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tabColor)),
                  focusedBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.tabColor)),
                  suffixIcon:  Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.tabColor,
                  ),
                  hintText: country != null ? country!.name : AppString.unitedState,
                  hintStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
                top: context.height10 - 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.width30,
                    child: TextField(
                      readOnly: true,
                      cursorColor: AppColors.tabColor,
                      decoration: InputDecoration(
                        hintText: '+',
                        enabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tabColor)),
                        focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tabColor)),
                        
                      ),
                    ),
                  ),
                  SizedBox(
                    width: context.width30 + 10,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorColor: AppColors.tabColor,
                      //initialValue: country != null ? country!.phoneCode : '1',
                      decoration: InputDecoration(
                        hintText: country != null ? country!.phoneCode : '1',
                        
                        enabledBorder:   UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tabColor)),
                        focusedBorder:   UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.tabColor)),
                        
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                   SizedBox(
                    width: context.width10,
                  ),
                  SizedBox(
                      width: 180,
                      child: TextField(
                        controller: phoneC,
                      cursorColor: AppColors.tabColor,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        decoration:  InputDecoration(
                          hintText: AppString.phoneNumber,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.tabColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: AppColors.tabColor)),
                        ),
                      )),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: verifyPhoneNumber,
              txt: AppString.next,
              size: const Size(90, 50),
              txtColor: Colors.black,
            ),
            SizedBox(
              height: context.height45 + 5,
            ),
          ],
        ),
      ),
    );
  }
}
