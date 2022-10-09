
import 'package:flutter/material.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';

import '../utils/app_strings.dart';
import '../utils/app_colors.dart';


bottomSheet(BuildContext context, Function()? pickImageCamera, Function()? pickImageGallery,) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.height20,
              vertical: context.height10 + 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.personalPhoto,
                  style: TextStyle(fontSize: context.font20),
                ),
                SizedBox(
                  height: context.height20,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: pickImageCamera,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.height10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white24, width: 1),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: AppColors.tabColor,
                            ),
                          ),
                          SizedBox(
                            height: context.height10,
                          ),
                          const Text(AppString.camera),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: context.width30,
                    ),
                    GestureDetector(
                      onTap: pickImageGallery,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(context.height10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border:
                                  Border.all(color: Colors.white24, width: 1),
                            ),
                            child: Icon(
                              Icons.photo,
                              color: AppColors.tabColor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(AppString.gallery),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }



