import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/app_colors.dart';
import 'package:whatsapp_getx/common/utils/component/components.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import 'package:whatsapp_getx/common/widgets/custom_bottom_sheet.dart';
import 'package:whatsapp_getx/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_getx/features/status/controller/status_controller.dart';

import '../../../common/picker/picker.dart';
import '../../../models/status_model.dart';
import '../../../routes.dart';

class StatusContactsScreen extends ConsumerStatefulWidget {
  const StatusContactsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<StatusContactsScreen> createState() =>
      _StatusContactsScreenState();
}

class _StatusContactsScreenState extends ConsumerState<StatusContactsScreen> {
  File? image;

  void pickImageGallery() async {
    image = await pickImageFromGallery(context);

    Components.navigateTo(
      context,
      Routes.confirmStatusScreen,
      image,
    );
    setState(() {});
  }

  void pickImageCamera() async {
    image = await pickImageFromCamera(context);
    Components.navigateTo(
      context,
      Routes.confirmStatusScreen,
      image,
    );
    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView(
      children: [
        Column(
          children: [
            ListTile(
              onTap: () async {
                bottomSheet(context, pickImageCamera, pickImageGallery);
              },
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: ref.read(userDataAuthProvider).when(
                      data: (data) {
                        return NetworkImage(data!.profilePic);
                      },
                      error: (e, trace) {
                        return const AssetImage(AppString.assetsPerson);
                      },
                      loading: () {
                        return const AssetImage(AppString.assetsPerson);
                      },
                    ),
                    radius: context.radius30,
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: context.radius15 - 5,
                        backgroundColor: AppColors.tabColor,
                        child: Icon(
                          Icons.add,
                          size: context.radius15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              title: const Text('My status'),
              subtitle: const Text('Tap to add status update'),
            ),
            Divider(color: AppColors.dividerColor, indent: 85),
          ],
        ),
        FutureBuilder<List<Status>>(
          future: ref.read(statusControllerProvider).getStatus(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            
            
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var dataList = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: context.height10 - 2),
                    child: ListTile(
                      onTap: () {
                        Components.navigateTo(
                            context, Routes.statusScreen, dataList);
                      },
                      title: Text(
                        dataList.username,
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          dataList.profilePic,
                        ),
                        radius: context.radius30,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}
