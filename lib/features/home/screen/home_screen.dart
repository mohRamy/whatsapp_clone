import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/app_colors.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import 'package:whatsapp_getx/routes.dart';

import '../../../common/picker/picker.dart';
import '../../../common/utils/component/components.dart';
import '../../../common/widgets/custom_bottom_sheet.dart';
import '../../auth/controller/auth_controller.dart';
import '../../chat/widgets/contacts_list.dart';
import '../../status/screens/status_contacts_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<HomeScreen>
    with WidgetsBindingObserver, TickerProviderStateMixin {
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

  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.appBarColor,
          centerTitle: false,
          title: Text(
            AppString.appHome,
            style: TextStyle(
              fontSize: context.font20,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.grey),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text(
                    'Create Group',
                  ),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                      context,
                      Routes.createGroupScreen,
                    ),
                  ),
                )
              ],
            ),
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: AppColors.tabColor,
            indicatorWeight: 4,
            labelColor: AppColors.tabColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactsList(),
            StatusContactsScreen(),
            Text('Calls'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (tabBarController.index == 0) {
              Navigator.pushNamed(context, Routes.selectContactScreen);
            } else if (tabBarController.index == 1) {
              bottomSheet(context, pickImageCamera, pickImageGallery);
            } else if (tabBarController.index == 2) {
              Navigator.pushNamed(context, Routes.selectContactScreen);
            }
          },
          backgroundColor: AppColors.tabColor,
          child: Icon(
            tabBarController.index == 0
                ? Icons.comment
                : tabBarController.index == 1
                    ? Icons.camera
                    : Icons.call,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
