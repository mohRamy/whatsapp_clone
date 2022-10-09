import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_getx/common/utils/app_strings.dart';
import 'package:whatsapp_getx/common/utils/app_colors.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import '../../auth/controller/auth_controller.dart';
import '../../../models/user_model.dart';
import '../widgets/bottom_chat_field.dart';
import '../widgets/chat_list.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  final bool isGroupChat; // select contact عند الخطأ زوده في
  final String profilePic;
  const ChatScreen({
    Key? key,
    required this.name,
    required this.uid,
    required this.isGroupChat,
    this.profilePic = AppString.assetsPerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
        automaticallyImplyLeading: false,
        title: StreamBuilder<UserModel>(
            stream: ref.read(authControllerProvider).userDataById(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }
              return Row(
                children: [
                  InkWell(
                      borderRadius: BorderRadius.circular(context.radius20),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                            ),
                            CircleAvatar(
                              radius: context.radius20,
                              backgroundImage: NetworkImage(profilePic),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(width: context.width10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name),
                      !isGroupChat
                          ? snapshot.data!.isOnline
                              ? Text(
                                  'online',
                                  style: TextStyle(
                                    fontSize: context.font16 - 3,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              : Container()
                          : Container(),
                    ],
                  ),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            AppString.assetsBackground,
            height: context.screenHeight,
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Expanded(
                child: ChatList(
                  recieverUserId: uid,
                  isGroupChat: isGroupChat,
                ),
              ),
              BottomChatField(
                recieverUserId: uid,
                isGroupChat: isGroupChat,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Row iconChat({
//   required IconData icon,
//   required double width,
// }) {
//   return Row(
//     children: [
//       InkWell(
//         borderRadius: BorderRadius.circular(50),
//         onTap: () {},
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             icon,
//           ),
//         ),
//       ),
//       SizedBox(
//         width: width,
//       ),
//     ],
//   );
// }

// appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Row(
//           children: [
//             InkWell(
//               borderRadius: BorderRadius.circular(50),
//               onTap: () => Navigator.pop(context),
//               child: Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.arrow_back),
//                     CircleAvatar(
//                       radius: 18,
//                       backgroundImage: NetworkImage(profilePic),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(width: 10),
//             StreamBuilder(
//               stream: ref.read(authControllerProvider).userDataById(uid),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return  Container();
//                 }
//                 return Column(
//               children: [
//                 Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 18,
//                   ),
//                 ),
//                 snapshot.data!.isOnline ?
//                 const Text(
//                   'online',
//                 style: TextStyle(
//                     color: Colors.white70,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 13,
//                   ),):
//                 Container(),
//               ],
//             );
//               },
//             ),
//           ],
//         ),
//         actions: [
//           iconChat(icon: Icons.video_call, width: 8),
//           iconChat(icon: Icons.call, width: 8),
//           iconChat(icon: Icons.more_vert, width: 5),
//         ],
//       ),
