import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';

import '../../../common/enums/message_enum.dart';
import '../../../common/utils/app_colors.dart';
import 'display_text_image_gif.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.isSeen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;
    String typeIcon() {
      String contactMsg;
      switch (repliedMessageType) {
        case MessageEnum.image:
          contactMsg = '📷 Photo';
          break;
        case MessageEnum.video:
          contactMsg = '📸 Video';
          break;
        case MessageEnum.audio:
          contactMsg = '🎵 Audio';
          break;
        case MessageEnum.gif:
          contactMsg = 'GIF';
          break;
        default:
          contactMsg = 'GIF';
      }
      return contactMsg;
    }

    return SwipeTo(
      onRightSwipe: onLeftSwipe,
      child: Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: type == MessageEnum.text ? 130 : 200,
              maxWidth: 270,
            ),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              color: AppColors.messageColor,
              margin: EdgeInsets.symmetric(
                  horizontal: context.height15, vertical: context.height10 - 5),
              child: type == MessageEnum.text || type == MessageEnum.audio
                  ? Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: context.height10 - 5,
                            right: context.height10 - 5,
                            top: context.height10,
                            bottom: context.height20,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: context.height10 - 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isReplying
                                    ? repliedMessageType == MessageEnum.text ||
                                            repliedMessageType ==
                                                MessageEnum.audio
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.all(
                                                    context.height10 - 5),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .backgroundColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      username ==
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .displayName
                                                          ? username
                                                          : 'You',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: username ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .displayName
                                                            ? Colors.orange
                                                            : AppColors
                                                                .tabColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          context.height10 - 5,
                                                    ),
                                                    DisplayTextImageGIF(
                                                      message: repliedText,
                                                      type: repliedMessageType,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: context.height10,
                                              ),
                                              DisplayTextImageGIF(
                                                message: message,
                                                type: type,
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .backgroundColor
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          context.height10 - 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            username ==
                                                                    FirebaseAuth
                                                                        .instance
                                                                        .currentUser!
                                                                        .displayName
                                                                ? 'You'
                                                                : username,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: username ==
                                                                      FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .displayName
                                                                  ? Colors
                                                                      .orange
                                                                  : AppColors
                                                                      .tabColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: context
                                                                    .height10 -
                                                                5,
                                                          ),
                                                          Text(
                                                            typeIcon(),
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .white60,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(5),
                                                        bottomRight:
                                                            Radius.circular(5),
                                                      ),
                                                      child: SizedBox(
                                                        height:
                                                            context.height45 +
                                                                5,
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: repliedText,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: context.height10 - 5,
                                              ),
                                              DisplayTextImageGIF(
                                                message: message,
                                                type: type,
                                              ),
                                            ],
                                          )
                                    : DisplayTextImageGIF(
                                        message: message,
                                        type: type,
                                      ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: context.height10 - 5,
                          right: context.height10 - 5,
                          child: Row(
                            children: [
                              Text(
                                date,
                                style: TextStyle(
                                  fontSize: context.font16 - 3,
                                  color: Colors.white60,
                                ),
                              ),
                              SizedBox(
                                width: context.width10 - 5,
                              ),
                              Icon(
                                isSeen ? Icons.done_all : Icons.done,
                                size: context.iconSize16 + 4,
                                color: isSeen ? Colors.blue : Colors.white60,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: DisplayTextImageGIF(
                              message: message,
                              type: type,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Row(
                            children: [
                              Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Icon(
                                isSeen ? Icons.done_all : Icons.done,
                                size: 20,
                                color: isSeen ? Colors.blue : Colors.white60,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          )),
    );
  }
}
