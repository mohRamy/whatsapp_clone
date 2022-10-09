import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_getx/common/utils/component/components.dart';
import 'package:whatsapp_getx/common/utils/dimensions.dart';
import 'package:whatsapp_getx/features/chat/widgets/video_item.dart';
import 'package:whatsapp_getx/routes.dart';

class VideoCard extends StatefulWidget {
  final String videoUrl;
  const VideoCard({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late CachedVideoPlayerController videoPlayerController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        CachedVideoPlayerController.network(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.pushNamed(
          //   context,
          //   VideoItem.routeName,
          //   arguments: widget.videoUrl,
          // );
          Components.navigateTo(context, Routes.videoItem, widget.videoUrl);
        },
        child: Stack(
          children: [
            CachedVideoPlayer(videoPlayerController),
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: Colors.black.withOpacity(0.2),
                radius: context.radius30 - 3,
                child: Icon(
                  Icons.play_arrow,
                  size: context.iconSize24 + 11,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ));
  }
}
