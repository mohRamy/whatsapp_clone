import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import 'package:whatsapp_getx/common/widgets/custom_bottom_sheet.dart';
import '../../../common/picker/picker.dart';
import '../../../common/utils/app_colors.dart';
import '../controller/auth_controller.dart';

import '../../../common/widgets/custom_button.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  const UserInformationScreen({super.key});

  @override
  ConsumerState<UserInformationScreen> createState() => _UserInformationState();
}

class _UserInformationState extends ConsumerState<UserInformationScreen> {
  TextEditingController nameC = TextEditingController();
  File? image;

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }

  void pickImageGallery() async {
    image = await pickImageFromGallery(context);
    Navigator.pop(context);
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera(context);
    Navigator.pop(context);
    setState(() {});
  }

  // showBottomSheet() {
  //   return showModalBottomSheet(
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(5),
  //         topRight: Radius.circular(5),
  //       ),
  //     ),
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SingleChildScrollView(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: context.height20,
  //             vertical: context.height10 + 2,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 AppString.personalPhoto,
  //                 style: TextStyle(fontSize: context.font20),
  //               ),
  //               SizedBox(
  //                 height: context.height20,
  //               ),
  //               Row(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: pickImageCamera,
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.all(context.height10),
  //                           decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             border:
  //                                 Border.all(color: Colors.white24, width: 1),
  //                           ),
  //                           child: Icon(
  //                             Icons.camera_alt,
  //                             color: AppColors.tabColor,
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           height: context.height10,
  //                         ),
  //                         const Text(AppString.camera),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: context.width30,
  //                   ),
  //                   GestureDetector(
  //                     onTap: pickImageGallery,
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           padding: EdgeInsets.all(context.height10),
  //                           decoration: BoxDecoration(
  //                             shape: BoxShape.circle,
  //                             border:
  //                                 Border.all(color: Colors.white24, width: 1),
  //                           ),
  //                           child: Icon(
  //                             Icons.photo,
  //                             color: AppColors.tabColor,
  //                           ),
  //                         ),
  //                         const SizedBox(
  //                           height: 10,
  //                         ),
  //                         const Text(AppString.gallery),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void saveUserData() {
    String name = nameC.text.trim();
    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context,
            name,
            image,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppString.profileInfo,
          style: TextStyle(
            color: AppColors.tabColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.height30),
        child: Column(
          children: [
            SizedBox(
              height: context.height20,
            ),
            const Text(
              AppString.namePhoto,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: context.height20,
            ),
            GestureDetector(
              onTap: bottomSheet(
                context,
                pickImageCamera,
                pickImageGallery,
              ),
              child: image != null
                  ? CircleAvatar(
                      radius: context.radius30 + 10,
                      backgroundColor: Colors.white60,
                      backgroundImage: FileImage(image!),
                    )
                  : CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white60,
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black45,
                        size: context.iconSize24 + 6,
                      ),
                    ),
            ),
            SizedBox(height: context.height20 + 5),
            TextField(
              controller: nameC,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: AppString.typeName,
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tabColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.tabColor)),
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: saveUserData,
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
