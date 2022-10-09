import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/component/components.dart';
import '../../../common/utils/app_colors.dart';
import '../../../common/widgets/error.dart';
import '../../../routes.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';

import '../controller/select_contacts_controller.dart';

class SelectContacts extends ConsumerWidget {
  const SelectContacts({super.key});

  // void selectContact(
  //     WidgetRef ref, Contact selectedContact, BuildContext context) {
  //   ref
  //       .read(selectContactsControllerProvider)
  //       .selectContact(selectedContact, context);
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isInvite = false;
    var isContactsOn = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text('select contact'),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(context.radius30 + 20),
                child: Padding(
                  padding: EdgeInsets.all(context.height10 - 2),
                  child: const Icon(
                    Icons.search,
                  ),
                ),
              ),
              SizedBox(
                width: context.height10 - 4,
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(context.radius30 + 20),
                child: Padding(
                  padding: EdgeInsets.all(context.height10 - 2),
                  child: const Icon(
                    Icons.more_vert,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          newContacts(
            onTap: () =>
                Components.navigateTo(context, Routes.createGroupScreen, {}),
            txt: 'New group',
            leadingIcon: Icons.group,
            trailingIcon: const Icon(
              Icons.grid_view_outlined,
              color: Colors.transparent,
            ),
          ),
          const SizedBox(height: 10),
          newContacts(
            onTap: () {},
            txt: 'New contact',
            leadingIcon: Icons.person_add,
            trailingIcon: const Icon(
              Icons.grid_view_outlined,
              color: Colors.grey,
            ),
          ),
          isContactsOn == true ? Padding(
            padding: EdgeInsets.only(
              left: context.height20,
              top: context.height15,
              bottom: context.height15,
            ),
            child: const Text(
              AppString.contactsOnWhatsApp,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ) : Container(),
          ref.read(foundCotnactsProvider).when(
            data: (data) {
              isContactsOn = true;
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var listData = data[index];
                    return ListTile(
                      onTap: () {
                        Components.navigateTo(
                          context,
                          Routes.chatScreen,
                          {
                            AppString.argumentName: listData.name,
                            AppString.argumentUid: listData.uid,
                            AppString.argumentisGroupChat: false,
                            AppString.argumentImage: listData.profilePic,
                          },
                        );
                      },
                      leading: CircleAvatar(
                        radius: context.radius20,
                        backgroundImage: NetworkImage(
                          listData.profilePic,
                        ),
                      ),
                      title: Text(listData.name),
                      subtitle: const Text('status'),
                    );
                  },
                ),
              );
            },
            error: (e, trace) {
              return ErrorScreen(error: e.toString());
            },
            loading: () {
              return Container();
            },
          ),
          isInvite == true ?
          Padding(
            padding: EdgeInsets.only(
              left: context.height20,
              top: context.height15,
              bottom: context.height15,
            ),
            child: const Text(
              AppString.invite,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ) : Container(),
          ref.read(getCotnactsProvider).when(
            data: (data) {
              isInvite = true;
              return Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var listData = data[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: context.radius20,
                      backgroundImage: const AssetImage(
                        AppString.assetsPerson,
                      ),
                    ),
                    title: Text(listData.displayName),
                    subtitle: const Text('status'),
                    trailing: Text(
                      'INVITE',
                      style: TextStyle(
                        color: AppColors.tabColor,
                        letterSpacing: 1,
                      ),
                    ),
                  );
                },
              ));
            },
            error: (e, trace) {
              return ErrorScreen(error: e.toString());
            },
            loading: () {
              return Container();
            },
          ),
        ],
      ),
    );
  }

  ListTile newContacts({
    required String txt,
    required IconData leadingIcon,
    required Icon trailingIcon,
    required Function()? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(txt),
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.tabColor,
        child: Icon(
          leadingIcon,
          color: Colors.white,
        ),
      ),
      trailing: trailingIcon,
    );
  }
}
