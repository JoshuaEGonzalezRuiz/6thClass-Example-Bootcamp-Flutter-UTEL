import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideosMobilePage extends StatefulWidget {
  const VideosMobilePage({super.key});

  @override
  State<VideosMobilePage> createState() => _VideosMobilePageState();
}

class _VideosMobilePageState extends State<VideosMobilePage> {
  VideoPlayerController assetVideoController =
      VideoPlayerController.asset("assets/videos/video.mp4");

  VideoPlayerController fileVideoController = VideoPlayerController.file(File(
      '/storage/sdcard0/Movies/premio_video.mp4')); //Reemplaza esta ruta con alguna que esté en tu dispositivo móvil

  YoutubePlayerController youtubePlayerController =
      YoutubePlayerController.fromVideoId(
    videoId: 'V6ankcHn85k',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  void initState() {
    assetVideoController.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
    fileVideoController.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const Text("Assets video"),
          const Divider(),
          assetVideoController.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    assetVideoController.value.isPlaying
                        ? assetVideoController.pause()
                        : assetVideoController.play();
                  },
                  child: AspectRatio(
                    aspectRatio: assetVideoController.value.aspectRatio,
                    child: VideoPlayer(assetVideoController),
                  ),
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 25,
          ),
          const Divider(),
          const Text("File video"),
          const Divider(),
          fileVideoController.value.isInitialized
              ? GestureDetector(
                  onTap: () {
                    fileVideoController.value.isPlaying
                        ? fileVideoController.pause()
                        : fileVideoController.play();
                  },
                  child: AspectRatio(
                    aspectRatio: fileVideoController.value.aspectRatio,
                    child: VideoPlayer(fileVideoController),
                  ),
                )
              : const SizedBox.shrink(),
          const Divider(),
          const Text("Youtube video"),
          const Divider(),
          YoutubePlayer(
            controller: youtubePlayerController,
            aspectRatio: 16 / 9,
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}
