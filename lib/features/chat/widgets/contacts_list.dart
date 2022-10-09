import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/component/components.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import 'package:whatsapp_getx/features/chat/controller/chat_controller.dart';
import 'package:whatsapp_getx/routes.dart';

import '../../../models/chat_contact.dart';
import '../../../models/group.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: context.height10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<Group>>(
                stream: ref.watch(chatControllerProvider).chatGroups(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var groupData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Components.navigateTo(
                          context,
                          Routes.chatScreen,
                          {
                            AppString.argumentName: groupData.name,
                            AppString.argumentUid: groupData.groupId,
                            AppString.argumentisGroupChat : false,
                            AppString.argumentImage: groupData.groupPic,
                          },
                        );
                            },
                            child: Padding(
                              padding:  EdgeInsets.only(bottom: context.height10 - 2),
                              child: ListTile(
                                title: Text(
                                  groupData.name,
                                  style:  TextStyle(
                                    fontSize: context.font16 + 2,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding:  EdgeInsets.only(top: context.height10 - 4),
                                  child: Text(
                                    groupData.lastMessage,
                                    style:  TextStyle(fontSize: context.font16 - 1),
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    groupData.groupPic,
                                    
                                  ),
                                  radius: context.radius30,
                                ) ,
                                trailing: Text(
                                  DateFormat.jm().format(groupData.timeSent),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: context.font16 - 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
            StreamBuilder<List<ChatContact>>(
                stream: ref.watch(chatControllerProvider).chatContacts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Container();
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var chatContactData = snapshot.data![index];

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Components.navigateTo(
                                context,
                                Routes.chatScreen,
                                {
                                  AppString.argumentName: chatContactData.name,
                                  AppString.argumentUid:
                                      chatContactData.contactId,
                                  AppString.argumentisGroupChat: false,
                                  AppString.argumentImage:
                                      chatContactData.profilePic,
                                },
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: context.height10 - 2),
                              child: ListTile(
                                title: Text(
                                  chatContactData.name,
                                  style: TextStyle(
                                    fontSize: context.font16 + 2,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: context.height10 - 4),
                                  child: Text(
                                    chatContactData.lastMessage,
                                    style: TextStyle(fontSize: context.font16 - 1),
                                  ),
                                ),
                                leading: chatContactData.profilePic.isNotEmpty ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    chatContactData.profilePic,
                                  ),
                                  radius: context.radius30,
                                ) :  CircleAvatar(
                                  backgroundImage: const AssetImage(
                                    AppString.assetsPerson,
                                  ),
                                  radius: context.radius30,
                                ),
                                trailing: Text(
                                  DateFormat.jm()
                                      .format(chatContactData.timeSent),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: context.font16 - 3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //const Divider(color: dividerColor, indent: 85),
                        ],
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
